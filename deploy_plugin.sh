#!/bin/bash
set -e
PLUGIN=build/src/filter/kaleid0sc0pe/kaleid0sc0pe.so

# Determine plugin target dir
TARGET="./squashfs-root-new/usr/lib/frei0r-1"
if [ ! -d "$TARGET" ]; then
  echo "[🚨] Target plugin dir not found: $TARGET"
  echo "Please set FREI0R_PATH manually."
  exit 1
fi

echo "[📦] Copying $PLUGIN → $TARGET"
cp "$PLUGIN" "$TARGET"
chmod +x "$TARGET/kaleid0sc0pe.so"

echo "[🌐] Exporting FREI0R_PATH=$TARGET"
export FREI0R_PATH="$TARGET"

echo "[🔍] Verifying plugin appears in melt filter list..."
melt -query filters | grep -i kaleid0sc0pe && echo "[✅] Success: Plugin registered!" || echo "[❌] Plugin not found."
