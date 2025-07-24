#!/bin/bash
# scrub_rgbshift0r_filter.sh
# Removes all references to frei0r.rgbshift0r from Kdenlive project XMLs

echo "🧽 Scrubbing 'frei0r.rgbshift0r' from all patched.kdenlive files..."

count=0
for file in $(find jobs -name "patched.kdenlive"); do
  echo "🔍 Checking $file"

  # Remove full <filter> blocks that contain 'frei0r.rgbshift0r'
  sed -i '/<filter>/,/<\/filter>/{
    /frei0r.rgbshift0r/{
      :a
      N
      /<\/filter>/!ba
      d
    }
  }' "$file"

  # Remove lone property lines (e.g., inline filters)
  sed -i '/frei0r\.rgbshift0r/d' "$file"

  ((count++))
done

echo "✅ Scrubbing complete. Processed $count .kdenlive file(s)."
