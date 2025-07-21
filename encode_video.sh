#!/bin/bash
INPUT_DIR="render_frames"
OUTPUT="output/kaleidoscopic_camouflage_4k.mp4"
FPS=60
PRESET="slow"
CRF=18

mkdir -p output

ffmpeg -y -r $FPS -i "$INPUT_DIR/frame_%04d.png" \
       -c:v libx264 -preset $PRESET -crf $CRF \
       -x264-params "ref=6:keyint=120:no-scenecut=1" \
       -pix_fmt yuv420p10le \
       -color_primaries bt2020 -color_trc smpte2084 -colorspace bt2020nc \
       -movflags +faststart \
       "$OUTPUT"

echo "Video encoded to $OUTPUT"
