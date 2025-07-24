#!/bin/bash
set -e

INPUT="$1"
OUTPUT="final_output.mp4"

echo "🎬 Rendering $INPUT to $OUTPUT..."
./squashfs-root-new/usr/bin/melt "$INPUT" -consumer avformat:$OUTPUT vcodec=libx264 acodec=aac threads=0 f=mp4 real_time=-1

echo "✅ Done: $OUTPUT"
