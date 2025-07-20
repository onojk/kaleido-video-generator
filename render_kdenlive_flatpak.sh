#!/usr/bin/env bash

# === Configuration ===
IMAGE_PATH="${1:-current_abstract_video_image.jpg}"
DURATION_SECONDS=10
PROJECT_TEMPLATE="render_this.kdenlive"
PATCHED_PROJECT="patched_render.kdenlive"
OUTPUT_VIDEO="final_output_$(date +%Y%m%d_%H%M%S).mp4"

# === AppImage melt path ===
APPIMAGE_ROOT="$HOME/KdenliveAppImage/squashfs-root"
MELT_BIN="$APPIMAGE_ROOT/usr/bin/melt"
FREI0R_PATH="$APPIMAGE_ROOT/usr/lib/frei0r-1"

# === Patch project file ===
echo "[+] Patching Kdenlive project for $IMAGE_PATH..."
python3 auto_patch_render_and_export.py "$IMAGE_PATH"

# === Start rendering ===
echo "[+] Starting melt render with AppImage version (kaleid0sc0pe support)"
env FREI0R_PATH="$FREI0R_PATH" "$MELT_BIN" "$PATCHED_PROJECT" \
  -consumer avformat:"$OUTPUT_VIDEO" \
  vcodec=libx264 acodec=aac ab=128k threads=2 real_time=0

echo "[✓] Render complete: $OUTPUT_VIDEO"
