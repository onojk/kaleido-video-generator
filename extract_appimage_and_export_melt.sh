#!/bin/bash
set -e

APPIMAGE=~/Downloads/kdenlive-25.04.3-x86_64.AppImage
EXTRACT_DIR=squashfs-root-new

# Re-extract every time to ensure fresh state
rm -rf "$EXTRACT_DIR"
chmod +x "$APPIMAGE"
"$APPIMAGE" --appimage-extract
mv squashfs-root "$EXTRACT_DIR"

# Export melt from extracted AppImage
export PATH="$PWD/$EXTRACT_DIR/usr/bin:$PATH"
echo "[✓] melt path set: $(which melt)"
