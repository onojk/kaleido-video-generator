#!/bin/bash
set -e

echo "[🚨] Starting clean_and_render.sh pipeline..."

# Constants
APPIMAGE_PATH="$HOME/Downloads/kdenlive-25.04.3-x86_64.AppImage"
EXTRACT_DIR="$HOME/kaleido-video-generator/squashfs-root-new"
PROJECT_TEMPLATE="render_this.kdenlive"
PATCHED_PROJECT="patched_render.kdenlive"
FINAL_IMAGE="current_abstract_video_image.jpg"
OUTPUT_FILE="final_output_cleaned.mp4"
PLUGIN_DIR="$EXTRACT_DIR/usr/lib/frei0r-1"
FALLBACK_PLUGIN_DIR="$HOME/kaleido-video-generator/frei0r_plugins_bundle"
RENDER_DURATION_SECONDS=10
RENDER_WIDTH=480
RENDER_HEIGHT=272

# Ensure xmlstarlet is installed
if ! command -v xmlstarlet &>/dev/null; then
  echo "[!] Missing 'xmlstarlet'. Please run: sudo apt install xmlstarlet"
  exit 1
fi

# Use existing extracted AppImage directory
if [ -d "$EXTRACT_DIR" ]; then
  echo "[📂] Using existing squashfs-root-new — skipping extraction."
else
  echo "[📦] Extracting AppImage..."
  chmod +x "$APPIMAGE_PATH"
  "$APPIMAGE_PATH" --appimage-extract
  mv squashfs-root "$EXTRACT_DIR"
fi

# Check plugin dependencies
echo "[🔍] Verifying required plugins in $PLUGIN_DIR..."
for plugin in kaleidoscope.so rgbshift0r.so; do
  if [ ! -f "$PLUGIN_DIR/$plugin" ]; then
    echo "[🩹] Attempting to copy missing plugin: $plugin"
    sudo cp "$FALLBACK_PLUGIN_DIR/$plugin" "$PLUGIN_DIR/$plugin"
    echo "[✓] Recovered: $plugin"
  else
    echo "[✓] Found: $plugin"
  fi
done

# Patch .kdenlive project
echo "[🧩] Patching $PROJECT_TEMPLATE → $PATCHED_PROJECT..."
cp "$PROJECT_TEMPLATE" "$PATCHED_PROJECT"

# Replace image path
xmlstarlet ed -L \
  -u "//property[@name='resource']" -v "$HOME/kaleido-video-generator/$FINAL_IMAGE" \
  "$PATCHED_PROJECT"

# Replace resolution
xmlstarlet ed -L \
  -u "//profile/@width" -v "$RENDER_WIDTH" \
  -u "//profile/@height" -v "$RENDER_HEIGHT" \
  "$PATCHED_PROJECT"

# Replace duration
DURATION_FRAMES=$((RENDER_DURATION_SECONDS * 60))
xmlstarlet ed -L \
  -u "//property[@name='duration']" -v "00:00:10.000" \
  "$PATCHED_PROJECT"

# Render
echo "[🎬] Rendering to $OUTPUT_FILE at ${RENDER_WIDTH}x${RENDER_HEIGHT} for ${RENDER_DURATION_SECONDS}s..."
"$EXTRACT_DIR/usr/bin/melt" "$PATCHED_PROJECT" \
  -profile atsc_480p_60 \
  -consumer avformat:"$OUTPUT_FILE" rescale=bilinear width=$RENDER_WIDTH height=$RENDER_HEIGHT threads=2 real_time=-1

# Done
if [ -f "$OUTPUT_FILE" ]; then
  FILESIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
  echo "[✅] Render complete — $OUTPUT_FILE size: $FILESIZE"
else
  echo "[❌] Render failed."
  exit 1
fi
