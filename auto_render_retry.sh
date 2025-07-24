#!/usr/bin/env bash
set -euo pipefail

TEMPLATE="render_this.kdenlive"
OUTPUT_PREFIX="rainbow_output_$(date +%Y%m%d-%H%M%S)"
MAX_ATTEMPTS=3
FPS=60

render_video() {
    local duration=$1
    local frames=$(echo "$duration * $FPS" | bc | awk '{printf "%.0f\n", $1}')
    
    echo "=== Rendering ${duration}s video (${frames} frames) ==="
    
melt \
  -profile colorspace=rgb \
  "$TEMPLATE" \
  -consumer avformat:"${OUTPUT_PREFIX}.mp4" \
    vcodec=libx264 \
    pix_fmt=yuv444p \
    color_range=pc \
    crf=18 \
    preset=slow \
    x264-params=ref=4:deblock=-1,-1 \
    movflags=+faststart \
    an=1 \
  in=0 \
  out="$frames" \
  -progress
}

main() {
    read -rp "⏱️ Enter video duration in seconds (1-60): " duration
    
    for ((attempt=1; attempt<=MAX_ATTEMPTS; attempt++)); do
        echo -e "\n=== Attempt $attempt/$MAX_ATTEMPTS ==="
        if render_video "$duration"; then
       echo -e "\n[✓] SUCCESS: ${OUTPUT_PREFIX}.mp4"
       echo "File size: $(du -h "${OUTPUT_PREFIX}.mp4" | cut -f1)"

       # Rename latest output to final_output.mp4 for predictable downloading
       mv "${OUTPUT_PREFIX}.mp4" final_output.mp4 && echo "[✓] Renamed to final_output.mp4"
            exit 0
        fi
        sleep 1
    done
    
    echo -e "\n[✗] Failed after $MAX_ATTEMPTS attempts"
    exit 1
}

main
