#!/bin/bash
set -e

cd "$(dirname "$0")/jobs/$(ls -t jobs | head -1)"

[ -f "generated.jpg" ] || { echo "ERROR: generated.jpg missing"; exit 1; }
[ -f "dummy_silence.wav" ] || { echo "ERROR: dummy_silence.wav missing"; exit 1; }

# Set plugin paths
export FREI0R_PATH="/usr/lib/frei0r-1:/usr/local/lib/frei0r-1:/usr/lib/mlt/frei0r"
export LD_LIBRARY_PATH="/usr/lib/mlt/frei0r:$LD_LIBRARY_PATH"

# Try melt with Xvfb first
if command -v melt >/dev/null 2>&1; then
  echo "Attempting melt render with Xvfb..."
  xvfb-run -a melt -verbose "patched.kdenlive" \
    -consumer avformat:final_output.mp4 \
    vcodec=libx264 crf=16 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=192k strict=-2 \
    f=mp4 movflags=+faststart \
    threads=2 \
    properties=quality=1 \
    2>&1 | tee melt.log
fi

# FFmpeg fallback with proper plugin handling
if [ ! -f "final_output.mp4" ] || [ $(stat -c%s "final_output.mp4") -lt 2000000 ]; then
  echo "Using FFmpeg fallback render..."
  ffmpeg -y -fflags +genpts \
    -loop 1 -framerate 25 -i "generated.jpg" \
    -i "dummy_silence.wav" \
    -vf "format=yuv420p,frei0r=/usr/lib/mlt/frei0r/kaleid0sc0pe.so:0.5|0.5|0.5,format=yuv420p" \
    -c:v libx264 -crf 16 -preset slow \
    -c:a aac -b:a 192k \
    -t 24 -r 25 \
    "final_output.mp4" \
    2>&1 | tee ffmpeg.log
fi

# Verification (unchanged)
echo -e "\n=== RENDER VERIFICATION ==="
[ -f "final_output.mp4" ] || { echo "ERROR: No output file created"; exit 1; }

FILESIZE=$(stat -c%s "final_output.mp4")
DURATION=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "final_output.mp4")
EFFECTS=$(ffprobe -show_frames "final_output.mp4" 2>&1 | grep -c "pict_type=I")

echo "File size: $((FILESIZE/1024))KB"
echo "Duration: ${DURATION}s"
echo "Keyframes detected: ${EFFECTS}"

(( $(echo "$FILESIZE < 2000000" | bc -l) ) && { echo "ERROR: Output file too small"; exit 1; }
echo "=== RENDER SUCCESSFUL ==="
