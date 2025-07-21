#!/bin/bash
set -eo pipefail

# Initialize
LOG_FILE="pipeline_$(date +%s).log"
exec > >(tee "$LOG_FILE") 2>&1

echo "=== STARTING PIPELINE ==="

# 1. Generate Base Image
python3 generate_camouflage.py \
    --width 48000 \
    --height 10800 \
    --output "base_camouflage.tif" || exit 1

# 2. Enhance Contrast
python3 enhance_contrast.py \
    --input "base_camouflage.tif" \
    --output "enhanced_camouflage.jpg" || exit 1

# 3. Render Frames
if ! python3 render_frames.py; then
    echo "ERROR: Frame rendering failed - check $LOG_FILE"
    exit 1
fi

# 4. Encode Video
ffmpeg -y -framerate 60 \
    -i "render_frames/frame_%04d.png" \
    -c:v libx265 -crf 18 -preset slow \
    -pix_fmt yuv420p10le \
    -x265-params "hdr10=1" \
    "output_4k.mp4" || exit 1

echo "=== PIPELINE COMPLETED SUCCESSFULLY ==="
