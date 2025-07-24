#!/bin/bash
# check_broken_kdenlive_projects.sh

echo "🔍 Scanning for .kdenlive files missing 'image_producer'..."

for f in jobs/*/patched.kdenlive; do
  if ! grep -q '<producer id="image_producer">' "$f"; then
    echo "❌ MISSING: $f"
  fi
done

echo "✅ Scan complete."
