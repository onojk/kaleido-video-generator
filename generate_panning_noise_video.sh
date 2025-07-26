#!/bin/bash
set -e

# Unique timestamp
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
IMG="prime_noise_${TIMESTAMP}.jpg"
OUT="panning_noise_${TIMESTAMP}.mp4"

# 1. Generate noise image (3840x1080)
python3 - <<END
import numpy as np
from PIL import Image

w, h = 3840, 1080
np.random.seed(sum([2, 3, 5, 7, 11, 13, 17]))
img = (255 * np.random.rand(h, w, 3) ** 1.5).astype(np.uint8)
Image.fromarray(img).save("$IMG")
print("✅ Saved noise image: $IMG")
END

# 2. Render panning + curve-filtered video
ffmpeg -y -loop 1 -i "$IMG" -vf "
crop=1920:1080:x='mod(t*60\,1920)':y=0,
curves=all='0/0|0.3/0.4|0.6/0.9|1/1':
       r='0/0|0.3/0.4|0.6/0.9|1/1':
       g='0/0|0.5/0.3|1/0.8':
       b='0/0|0.7/0.2|1/0.6',
format=yuv420p10le
" -t 10 -r 60 -c:v libx264 -preset slow -crf 17 -movflags +faststart "$OUT"

echo "🎉 Rendered video saved as: $OUT"
