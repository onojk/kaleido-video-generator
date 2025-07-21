#!/bin/bash
set -euo pipefail

echo "[🚨] Starting clean_and_render.sh pipeline..."

# --- Config ---
APPIMAGE_MELT_PATH="./squashfs-root-new/usr/bin/melt"
REQUIRED_PLUGINS_DIR="./squashfs-root-new/usr/lib/frei0r-1"
RENDER_TEMPLATE="render_this.kdenlive"
PATCHED_RENDER="patched_render.kdenlive"
OUTPUT_FILE="final_output_cleaned.mp4"
FPS=60

# Check melt binary exists
if [[ ! -x "$APPIMAGE_MELT_PATH" ]]; then
    echo "[❌] Melt binary not found or not executable at $APPIMAGE_MELT_PATH"
    exit 1
fi

# Prompt for video duration in seconds
read -rp "⏱️  Enter desired video duration (in seconds): " DURATION_SEC

# Calculate frame count
FRAME_COUNT=$(( DURATION_SEC * FPS ))

# Verify required plugins
echo "[🔍] Verifying required plugins in $REQUIRED_PLUGINS_DIR..."
PLUGIN_MISSING=0
for plugin in kaleidoscope.so rgbshift0r.so; do
    if [[ ! -f "${REQUIRED_PLUGINS_DIR}/${plugin}" ]]; then
        echo "[❌] Missing plugin: $plugin"
        PLUGIN_MISSING=1
    else
        echo "[✓] Found: $plugin"
    fi
done
if (( PLUGIN_MISSING )); then
    echo "[❌] One or more required plugins missing. Aborting."
    exit 1
fi

# Patch Kdenlive project duration
if [[ ! -f "$RENDER_TEMPLATE" ]]; then
    echo "[❌] Kdenlive project template '$RENDER_TEMPLATE' not found!"
    exit 1
fi

echo "[🧩] Patching $RENDER_TEMPLATE → $PATCHED_RENDER with duration $FRAME_COUNT frames..."
cp "$RENDER_TEMPLATE" "$PATCHED_RENDER"

# Use xmlstarlet or sed to update the duration in patched_render.kdenlive
# Example using xmlstarlet to update 'length' property under 'playlist' element:
if command -v xmlstarlet >/dev/null 2>&1; then
    xmlstarlet ed -L \
        -u "//playlist/property[@name='length']" -v "$FRAME_COUNT" \
        "$PATCHED_RENDER"
else
    # Fallback: simple sed replacement (may not be robust)
    sed -i -E "s/(<property name=\"length\">)[0-9]+(<\/property>)/\1${FRAME_COUNT}\2/" "$PATCHED_RENDER"
fi

echo "[🎬] Starting melt render to $OUTPUT_FILE for ${DURATION_SEC} seconds..."

# Run melt with full path
"$APPIMAGE_MELT_PATH" "$PATCHED_RENDER" -consumer avformat:"$OUTPUT_FILE" rescale=bilinear width=480 height=272 threads=2 real_time=-1

echo "[✅] Render complete — output saved to $OUTPUT_FILE"
