#!/bin/bash
set -e

JOB_ID="$1"
DURATION="$2"
JOB_DIR="jobs/$JOB_ID"
IMAGE="generated.jpg"
PATCHED="$JOB_DIR/patched.kdenlive"
LOGFILE="$JOB_DIR/render.log"

echo "[🔍] Verifying required plugins..."
# (Optional plugin check or copy logic here)

echo "[🎨] Generating rainbow image..."
python3 generate_rainbow_image.py "$JOB_DIR/$IMAGE"

echo "[🧾] Patching Kdenlive project..."
export JOB_ID="$JOB_ID"
python3 patch_kdenlive_10s.py jobs/$JOB_ID \
  --template template_project.kdenlive \
  --input "$JOB_DIR/$IMAGE" \
  --output "$PATCHED" \
  --duration "${DURATION:-10}"

echo "STARTED_RENDER" >> "$LOGFILE"
echo "[🔥] Rendering with melt..."

export MLT_REPOSITORY="$PROJECT_ROOT/squashfs-root-new/usr/lib/frei0r-1"
xvfb-run -a ./squashfs-root-new/usr/bin/melt "$PATCHED" -profile hd1080 -consumer avformat:"$JOB_DIR/output.mp4" vcodec=libx264 acodec=aac b=10M ab=128k threads=2 f=mp4 >> "$LOGFILE" 2>xvfb-run -a ./squashfs-root-new/usr/bin/melt "$PATCHED" -profile hd1080 -consumer avformat:"$JOB_DIR/output.mp4" vcodec=libx264 vb=10M acodec=aac ab=128k threads=2 >> "$LOGFILE" 2>xvfb-run -a ./squashfs-root-new/usr/bin/melt "$PATCHED" \11
  -profile hd1080 \
  -consumer avformat:"$JOB_DIR/output.mp4" vcodec=libx264 acodec=aac threads=2 \
  >> "$LOGFILE" 2>&1

echo "[✅] Render complete."
