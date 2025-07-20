#!/bin/bash

# === Configuration ===
KDENLIVE_PROJECT="patched_with_image.kdenlive"
OUTPUT_VIDEO="final_output_10s_effects.mp4"
MELT_BIN="$HOME/kaleido-video-generator/squashfs-root-new/usr/bin/melt"
FREI0R_PLUGINS="/usr/lib/x86_64-linux-gnu/frei0r-1"  # System path where kaleidoscope.so exists

# === Log Header ===
echo "[🎬] Rendering $KDENLIVE_PROJECT to $OUTPUT_VIDEO using AppImage melt"
echo "[🎨] FREI0R_PATH: $FREI0R_PLUGINS"
echo "[🧠] MELT path: $MELT_BIN"

# === Run Melt ===
env FREI0R_PATH="$FREI0R_PLUGINS" "$MELT_BIN" "$KDENLIVE_PROJECT" \
  -consumer avformat:"$OUTPUT_VIDEO" acodec=aac vcodec=libx264 ab=128k vb=5M

# === Completion Message ===
if [ $? -eq 0 ]; then
  echo "[✅] Render complete: $OUTPUT_VIDEO"
else
  echo "[❌] Render failed."
fi
