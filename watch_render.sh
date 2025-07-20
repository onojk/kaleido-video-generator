#!/bin/bash

OUTPUT="final_output_10s.mp4"
PROJECT="render_this_2.kdenlive"

# Start rendering in background
flatpak run --command=melt org.kde.kdenlive "$PROJECT" \
  -profile atsc_2160p_60 \
  -consumer avformat:$OUTPUT vcodec=libx264 acodec=aac ab=192k &

RENDER_PID=$!

# Wait for file to appear
echo "[+] Waiting for $OUTPUT to be created..."
while [ ! -f "$OUTPUT" ]; do
  sleep 1
done

echo "[+] File created. Tracking size..."
while kill -0 "$RENDER_PID" 2>/dev/null; do
  SIZE=$(du -h "$OUTPUT" | cut -f1)
  echo "[`date +%H:%M:%S`] Current size: $SIZE"
  sleep 1
done

# Final size
SIZE=$(du -h "$OUTPUT" | cut -f1)
echo "[✓] Render complete. Final size: $SIZE"
