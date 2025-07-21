#!/bin/bash
set -e

# Usage: ./melt_render_timeout.sh <duration_seconds> <kdenlive_project_file> [melt options...]

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <duration_seconds> <kdenlive_project_file> [melt options]"
  exit 1
fi

DURATION_SECONDS=$1
PROJECT_FILE=$2
shift 2

# Path to melt binary inside your extracted AppImage folder
MELT_BIN="$HOME/kaleido-video-generator/squashfs-root-new/usr/bin/melt"

if [ ! -x "$MELT_BIN" ]; then
  echo "[!] Melt binary not found or not executable at: $MELT_BIN"
  exit 1
fi

if [ ! -f "$PROJECT_FILE" ]; then
  echo "[!] Project file not found: $PROJECT_FILE"
  exit 1
fi

echo "[⏳] Starting melt for approx $DURATION_SECONDS seconds..."

# Launch melt in background with all remaining args passed through
"$MELT_BIN" "$PROJECT_FILE" "$@" &
MELT_PID=$!

echo "[ℹ️] Melt PID: $MELT_PID"

# Wait for specified duration, then kill melt
sleep "$DURATION_SECONDS"
echo "[⏹️] Timeout reached. Sending SIGINT to melt (PID $MELT_PID)..."
kill -2 "$MELT_PID"

# Wait for melt to exit cleanly
wait "$MELT_PID" 2>/dev/null

echo "[✅] Melt process ended."
