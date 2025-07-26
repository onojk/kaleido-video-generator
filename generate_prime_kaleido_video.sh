#!/bin/bash

# --- Step 1: Generate colorful prime noise image ---
echo "🎨 Generating prime noise image..."
output_img="prime_noise_$(date +%Y%m%d_%H%M%S).jpg"
python3 - <<EOF
import numpy as np
from PIL import Image
import time

w, h = 1920, 1080
t = int(time.time())
noise = np.fromfunction(lambda y, x: (x * y + t) % 255, (h, w), dtype=int)
r = (noise * 17) % 256
g = (noise * 31) % 256
b = (noise * 61) % 256
img = np.stack([r, g, b], axis=-1).astype(np.uint8)
Image.fromarray(img).save("$output_img")
EOF
echo "✅ Saved image: $output_img"

# --- Step 2: Generate timestamped video filename ---
timestamp=$(date +%Y%m%d_%H%M%S)
output_mp4="prime_kaleido_${timestamp}.mp4"

# --- Step 3: Run FFmpeg to create 10s video ---
echo "🎞️  Generating video..."
ffmpeg -hide_banner -loglevel error -loop 1 -i "$output_img" -vf "
  curves=all='0/0|0.3/0.4|0.6/0.9|1/1':
         r='0/0|0.3/0.4|0.6/0.9|1/1':
         g='0/0|0.5/0.3|1/0.8':
         b='0/0|0.7/0.2|1/0.6',
  scale=1920:1080:force_original_aspect_ratio=increase,
  format=yuv420p10le
" -c:v libx264 -preset slow -crf 17 \
   -t 10 -r 60 -movflags +faststart \
   -y "$output_mp4"

# --- Step 4: Move to Downloads and report ---
mv "$output_mp4" ~/Downloads/
echo "✅ Final video saved: ~/Downloads/$output_mp4"
