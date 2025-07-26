#!/bin/bash

# Fixed Kaleidoscope Generator with Correct Mirroring
# Uses reliable scrolling instead of zoompan to prevent timeouts

# Configuration
WIDTH=1920
HEIGHT=1080
DURATION=5
FPS=30
CRF=18
PRESET="fast"
OUTPUT="kaleido_4quad.mp4"  # Changed output name as per your example

# Create temp directory
TEMP_DIR="kaleido_temp"
mkdir -p "$TEMP_DIR"

# Cleanup function
cleanup() {
    echo "🧹 Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"
}
trap cleanup EXIT

# Step 1: Generate Extended Noise Base Image (2x width for panning)
echo "🌀 Step 1/6: Generating noise base image..."
python3 -c "
from PIL import Image
import numpy as np
img = np.random.randint(0, 255, ($HEIGHT, $WIDTH*2, 3), dtype=np.uint8)
Image.fromarray(img).save('$TEMP_DIR/noise_base.jpg')
" || { echo "❌ Image generation failed"; exit 1; }

# Step 2: Create Scrolling Video (more reliable than zoompan)
echo "📹 Step 2/6: Creating scrolling video..."
ffmpeg -y -loglevel error -loop 1 -i "$TEMP_DIR/noise_base.jpg" \
    -vf "scroll=horizontal=-0.02:vertical=0,fps=$FPS,format=yuv420p" \
    -t $DURATION -c:v libx264 -crf $CRF -preset $PRESET "$TEMP_DIR/pan.mp4" \
    || { echo "❌ Scroll video creation failed"; exit 1; }

# Step 3: Apply Kaleidoscope Effect
echo "✨ Step 3/6: Applying kaleidoscope effect..."
ffmpeg -y -loglevel error -i "$TEMP_DIR/pan.mp4" \
    -vf "frei0r=kaleid0sc0pe:0.5,format=yuv420p" \
    -c:v libx264 -crf $CRF -preset $PRESET "$TEMP_DIR/kaleido.mp4" \
    || { echo "❌ Kaleidoscope effect failed"; exit 1; }

# Step 4: Crop Bottom-Right Quadrant
echo "✂️ Step 4/6: Cropping quadrant..."
ffmpeg -y -loglevel error -i "$TEMP_DIR/kaleido.mp4" \
    -vf "crop=iw/2:ih/2:iw/2:ih/2,format=yuv420p" \
    -c:v libx264 -crf $CRF -preset $PRESET "$TEMP_DIR/q1.mp4" \
    || { echo "❌ Quadrant crop failed"; exit 1; }

# Step 5: Create Horizontal Mirror (FIXED MIRRORING)
echo "🪞 Step 5/6: Creating horizontal mirror..."
ffmpeg -y -loglevel error -i "$TEMP_DIR/q1.mp4" -filter_complex \
    "[0:v]hflip[left];[0:v][left]hstack=inputs=2,format=yuv420p[out]" \
    -map "[out]" -c:v libx264 -crf $CRF -preset $PRESET "$TEMP_DIR/hmirror.mp4" \
    || { echo "❌ Horizontal mirror failed"; exit 1; }

# Step 6: Create Vertical Mirror
echo "🔁 Step 6/6: Creating vertical mirror..."
ffmpeg -y -loglevel error -i "$TEMP_DIR/hmirror.mp4" -filter_complex \
    "[0:v]vflip[bottom];[0:v][bottom]vstack=inputs=2,format=yuv420p[out]" \
    -map "[out]" -c:v libx264 -crf $CRF -preset $PRESET "$OUTPUT" \
    || { echo "❌ Vertical mirror failed"; exit 1; }

echo -e "\n✅ Successfully created kaleidoscope video: $OUTPUT"
echo "💡 You can download it with:"
echo "   scp -i ~/Downloads/onojk-key.pem ubuntu@18.222.253.189:~/kaleido-video-generator/kaleido_4quad.mp4 ~/Downloads/"
