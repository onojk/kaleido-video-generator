#!/bin/bash
set -e

# Set PROJECT_ROOT
PROJECT_ROOT="/home/ubuntu/kaleido-video-generator"
cd "$PROJECT_ROOT"

# Get most recent JOB_ID
export JOB_ID=$(ls -td jobs/*/ | head -1 | cut -d'/' -f2)
echo "🛠  Rendering job: $JOB_ID"

# Activate virtualenv
source venv/bin/activate

# Check if fixed.mlt exists; if not, generate it
if [[ ! -f jobs/$JOB_ID/fixed.mlt ]]; then
  echo "⚙️  fixed.mlt not found. Generating it..."
  python3 generate_fixed_mlt.py \
    --input jobs/$JOB_ID/current_abstract_video_image.jpg \
    --output jobs/$JOB_ID/fixed.mlt
fi

# Run melt to generate final video
xvfb-run -a melt jobs/$JOB_ID/fixed.mlt \
  -profile auto \
  -consumer avformat:jobs/$JOB_ID/final_output_cleaned.mp4 \
    res=1280x720 \
    vcodec=libx264 \
    acodec=aac \
    threads=2 \
    frame_rate_num=60 \
    frame_rate_den=1

echo "✅ Render complete: jobs/$JOB_ID/final_output_cleaned.mp4"
