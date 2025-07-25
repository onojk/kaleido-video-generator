#!/bin/bash
# Usage: ./render_debug_job.sh 3b9854e5-630a-444e-ab10-ad086152d69f

JOB_ID="$1"
PATCHED="jobs/$JOB_ID/patched.kdenlive"
OUT="outputs/${JOB_ID}_diag.mp4"
LOG="logs/render_${JOB_ID}_$(date +%H%M%S).log"
MLT_PATH="./squashfs-root-new/usr/lib/frei0r-1"

echo "=== 🔍 Rendering job: $JOB_ID"
echo "=== 🔗 Output: $OUT"
echo "=== 📄 Logging to: $LOG"
echo "=== 📦 Plugin dir: $MLT_PATH"
echo "==="

MLT_REPOSITORY="$MLT_PATH" \
MLT_LOG_LEVEL=debug \
echo "=== 📄 Logging to: $LOG"

echo ">>> PATCHED FILE CONTENT:" >> "$LOG"

cat "$PATCHED" >> "$LOG"
xvfb-run -a ./squashfs-root-new/usr/bin/melt "$PATCHED" \
  -profile hd720 \
  -consumer avformat:$OUT vcodec=libx264 acodec=aac threads=2 \
  > "$LOG" 2>&1

echo "=== ✅ Done rendering. Check:"
echo "    🔹 Video: $OUT"
echo "    🔹 Log: $LOG"
