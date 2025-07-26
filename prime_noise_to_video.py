#!/bin/bash

# === SETTINGS ===
WIDTH=1920
HEIGHT=1080
DURATION=10
FPS=60
CRF=17
PRESET="slow"

# === PATH SETUP ===
JOB_DIR="$HOME/kaleido_jobs"
mkdir -p "$JOB_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
IMG_FILE="$JOB_DIR/kaleido_input_$TIMESTAMP.jpg"
OUT_FILE="$JOB_DIR/kaleido_output_$TIMESTAMP.mp4"

# === GENERATE PRIME-NOISE IMAGE ===
echo "[🎨] Generating psychedelic noise image..."
python3 - <<EOF
from PIL import Image
import numpy as np
from datetime import datetime

w, h = $WIDTH, $HEIGHT
np.random.seed(int(datetime.now().timestamp()))
base = np.random.rand(h, w, 3) * 255
noise = (np.sin(np.linspace(0, 100, w)) + np.cos(np.linspace(0, 100, h)[:, None])) * 127
img_array = (base + noise[..., None]) % 255
img = Image.fromarray(img_array.astype('uint8'))
img.save("$IMG_FILE")
EOF

# === RUN FFmpeg with pan and color curves ===
echo "[🎬] Rendering video with pan + curves to $OUT_FILE..."
ffmpeg -y -loop 1 -i "$IMG_FILE" -vf "
  scale=iw*1.5:ih*1.5,
  crop=${WIDTH}:${HEIGHT}:'(in_w-out_w)*t/$DURATION':0,
  curves=all='0/0|0.3/0.4|0.6/0.9|1/1':
         r='0/0|0.3/0.4|0.6/0.9|1/1':
         g='0/0|0.5/0.3|1/0.8':
         b='0/0|0.7/0.2|1/0.6',
  format=yuv420p10le
" -t $DURATION -r $FPS -c:v libx264 -preset $PRESET -crf $CRF \
-movflags +faststart "$OUT_FILE"

# === PLAYBACK (optional) ===
echo "[▶️] Done! Previewing..."
ffplay "$OUT_FILE"
