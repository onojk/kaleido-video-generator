#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <JOB_ID>"
  exit 1
fi

JOB_ID="$1"
JOB_DIR="jobs/$JOB_ID"
OUTPUT_MP4="$JOB_DIR/final_output_cleaned.mp4"

echo "🔧 [step 1] Patching .kdenlive for job $JOB_ID"
python3 patch_kdenlive_10s.py "$JOB_DIR"

echo "🎬 [step 2] Rendering with melt..."
xvfb-run -a ./squashfs-root-new/usr/bin/melt "$JOB_DIR/patched.kdenlive" \
  -profile hd1080p60 \
  -consumer avformat:"$OUTPUT_MP4" \
  vcodec=libx264 acodec=aac width=3840 height=2160 r=60 threads=2

echo "📏 [step 3] Validating output size..."
./validate_render_size.sh "$OUTPUT_MP4"

echo "✅ All steps completed successfully!"
