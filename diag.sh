#!/usr/bin/env bash
# diag.sh — Diagnostics for Kaleidoscope Video Generator
set -euo pipefail

echo "===== Kaleidoscope Diagnostics $(date) ====="
echo "User: $(whoami) | Host: $(hostname)"
echo ""

echo "--- Python ---"
python3 --version
pip3 list 2>/dev/null | grep -E 'Flask|Pillow|gunicorn|scikit|numpy|psutil' || true

echo ""
echo "--- System tools ---"
for cmd in ffmpeg convert; do
  if command -v "$cmd" &>/dev/null; then
    echo "✅  $cmd: $(command -v $cmd)"
  else
    echo "❌  $cmd: NOT FOUND"
  fi
done

echo ""
echo "--- FFmpeg filters ---"
if command -v ffmpeg &>/dev/null; then
  ffmpeg -hide_banner -filters 2>/dev/null | grep -i frei0r || echo "(no frei0r filters)"
fi

echo ""
echo "--- Jobs directory ---"
JOBS_DIR="$(dirname "$0")/jobs"
if [[ -d "$JOBS_DIR" ]]; then
  JOB_COUNT=$(ls "$JOBS_DIR" | wc -l)
  echo "Job count: $JOB_COUNT"
  LATEST=$(ls -td "$JOBS_DIR"/*/  2>/dev/null | head -1)
  if [[ -n "$LATEST" ]]; then
    echo "Latest: $LATEST"
    ls -la "$LATEST"
    echo "--- Latest job.log (last 20 lines) ---"
    tail -20 "$LATEST/job.log" 2>/dev/null || echo "(no log)"
  fi
else
  echo "No jobs/ directory yet"
fi

echo ""
echo "--- Disk / Memory ---"
df -h "$(dirname "$0")"
free -h

echo ""
echo "===== Diagnostics complete ====="
