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
python3 patch_kdenlive_10s.py

echo "STARTED_RENDER" >> "$LOGFILE"
echo "[🔥] Rendering with melt..."

xvfb-run -a ./squashfs-root-new/usr/bin/melt "$PATCHED" \
  -profile hd1080 \
  -consumer avformat:"$JOB_DIR/output.mp4" vcodec=libx264 acodec=aac threads=2 \
  >> "$LOGFILE" 2>&1

echo "[✅] Render complete."
