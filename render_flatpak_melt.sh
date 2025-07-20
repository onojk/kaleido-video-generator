#!/bin/bash
set -e

INPUT="$1"
OUTPUT="final_output_$(date +%Y%m%d_%H%M%S).mp4"

if [[ ! -f "$INPUT" ]]; then
  echo "[!] Usage: $0 patched.kdenlive"
  exit 1
fi

echo "[+] Rendering with Flatpak melt..."
flatpak run --command=melt org.kde.kdenlive "$INPUT" \
  -consumer avformat:"$HOME/Videos/$OUTPUT" vcodec=libx264 acodec=none \
  preset=ultrafast crf=51 threads=1 progress=1

echo "[✓] Render complete: $HOME/Videos/$OUTPUT"
