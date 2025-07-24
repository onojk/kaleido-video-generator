#!/bin/bash
# fix_kdenlive_pixbuf_patch.sh
# Description: Replaces qimage with pixbuf in all patched Kdenlive project files for headless compatibility.

set -e

echo "🔍 Searching for patched .kdenlive files in jobs/*/..."

# Loop through each patched project file
for f in jobs/*/patched.kdenlive; do
  if [[ -f "$f" ]]; then
    echo "🔧 Patching $f ..."
    sed -i 's|<property name="mlt_service">qimage</property>|<property name="mlt_service">pixbuf</property>|' "$f"

    echo "🔎 Verifying image_producer entry:"
    grep -A2 '<producer id="image_producer">' "$f" || echo "⚠️ image_producer not found!"
    echo ""
  else
    echo "⚠️ No patched.kdenlive file found at $f"
  fi
done

echo "✅ All Kdenlive projects patched for pixbuf compatibility."
