#!/bin/bash
set -euo pipefail  # Strict error handling

echo -e "=== STARTING RENDER PIPELINE ===\n"

# ======================
# 1. DEPENDENCY CHECKS
# ======================
echo "--- Checking dependencies ---"
command -v python3 >/dev/null 2>&1 || { echo >&2 "[!] Python 3 required but not found. Aborting."; exit 1; }
command -v MLT_PREFIX= melt -progress \
  -consumer avformat:final_output.mp4 \
    vcodec=libx264 crf=16 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=192k strict=-2 \
    f=mp4 movflags=+faststart \
    threads=2 \
    properties=quality=1
  vcodec=libx264 crf=18 preset=slow pix_fmt=yuvj420p \
  acodec=aac ab=128k strict=-2 \
  f=mp4 movflags=+faststart \
  threads=2 \
  properties=lossless=1
command -v xvfb-run >/dev/null 2>&1 || { echo >&2 "[!] Xvfb required but not found. Aborting."; exit 1; }
command -v ffmpeg >/dev/null 2>&1 || { echo >&2 "[!] ffmpeg required but not found. Aborting."; exit 1; }

# ======================
# 2. SETUP ENVIRONMENT
# ======================
JOB_ID=$(uuidgen)
JOB_FOLDER="jobs/$JOB_ID"
TEMPLATE="template_project.kdenlive"
export LADSPA_PATH="/usr/lib/ladspa:/usr/lib/x86_64-linux-gnu/ladspa"

echo -e "\n--- Job Details ---"
echo "Job ID: $JOB_ID"
echo "Job folder: $JOB_FOLDER"
echo "LADSPA_PATH: $LADSPA_PATH"

# ======================
# 3. CREATE WORKSPACE
# ======================
mkdir -p "$JOB_FOLDER" || { echo >&2 "[!] Failed to create job folder"; exit 1; }
echo -e "\n[✓] Created job folder"

# ======================
# 4. GENERATE CONTENT
# ======================
echo -e "\n--- Generating Content ---"

# Generate image
echo "Generating abstract image..."
if ! python3 generate_rainbow_contrast.py --output "$JOB_FOLDER/generated.jpg"; then
    echo >&2 "[!] Failed to generate image"
    exit 1
fi

if [ ! -f "$JOB_FOLDER/generated.jpg" ]; then
    echo >&2 "[!] Generated image missing"
    exit 1
fi
echo "[✓] Image generated ($(du -h "$JOB_FOLDER/generated.jpg" | cut -f1))"

# Validate template
if [ ! -f "$TEMPLATE" ]; then
    echo >&2 "[!] Template file $TEMPLATE not found"
    exit 1
fi

# ======================
# 5. PATCH PROJECT
# ======================
echo -e "\n--- Patching Project ---"
PATCHED_PROJECT="$JOB_FOLDER/patched.kdenlive"

if ! python3 patch_kdenlive_10s.py \
    "$TEMPLATE" \
    "$JOB_FOLDER/generated.jpg" \
    "$PATCHED_PROJECT"; then
    echo >&2 "[!] Failed to patch project file"
    exit 1
fi

if [ ! -f "$PATCHED_PROJECT" ]; then
    echo >&2 "[!] Patched project file not created"
    exit 1
fi
echo "[✓] Project patched successfully"

# ======================
# 6. GENERATE AUDIO
# ======================
echo -e "\n--- Generating Audio ---"
if ! ./generate_dummy_audio.sh "$JOB_FOLDER"; then

# Verify OpenGL support
glxinfo | grep -E "OpenGL vendor|OpenGL renderer"
# Check frei0r plugins
MLT_PREFIX= melt -progress \
  -consumer avformat:final_output.mp4 \
    vcodec=libx264 crf=16 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=192k strict=-2 \
    f=mp4 movflags=+faststart \
    threads=2 \
    properties=quality=1
  vcodec=libx264 crf=18 preset=slow pix_fmt=yuvj420p \
  acodec=aac ab=128k strict=-2 \
  f=mp4 movflags=+faststart \
  threads=2 \
  properties=lossless=1

    echo >&2 "[!] Failed to generate audio"
    exit 1
fi
echo "[✓] Audio generated"

# ======================
# 7. RENDER VIDEO
# ======================
echo -e "\n--- Starting Render ---"
cd "$JOB_FOLDER" || { echo >&2 "[!] Failed to enter job folder"; exit 1; }

RENDER_CMD=(
    xvfb-run -a melt
    "patched.kdenlive" -progress
    -consumer "avformat:final_output.mp4"
    aresample=async=1000,acodec=aac ab=128k strict=-2
    vcodec=libx264 vb=8000k
)

echo "Executing: ${RENDER_CMD[*]}"
if ! "${RENDER_CMD[@]}"; then
    echo >&2 "[!] Primary render failed, attempting fallback..."
    
    # Fallback without xvfb
    if ! MLT_PREFIX= SWRENDER=1 MLT_PREFIX= SWRENDER=1 MLT_PREFIX= melt -progress \
  -consumer avformat:final_output.mp4 \
    vcodec=libx264 crf=16 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=192k strict=-2 \
    f=mp4 movflags=+faststart \
    threads=2 \
    properties=quality=1
  vcodec=libx264 crf=18 preset=slow pix_fmt=yuvj420p \
  acodec=aac ab=128k strict=-2 \
  f=mp4 movflags=+faststart \
  threads=2 \
  properties=lossless=1
  -consumer avformat:final_output.mp4 \
    vcodec=libx264 crf=16 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=192k strict=-2 \
    f=mp4 movflags=+faststart \
    threads=2 \
    properties=quality=1
    vcodec=libx264 crf=18 preset=slow pix_fmt=yuv420p \
    acodec=aac ab=128k strict=-2 \
    f=mp4 movflags=+faststart+skip_sidx+skip_trailer \
    threads=0
  vcodec=libx264 crf=18 preset=slow pix_fmt=yuv420p \
  acodec=aac ab=128k ar=48000 \
  f=mp4 movflags=+faststart+skip_sidx+skip_trailer \
  threads=0
    video_geometry=1920x1080 threads=0 \
         -consumer "avformat:final_output.mp4" \
         aresample=async=1000,acodec=aac ab=128k strict=-2 vcodec=libx264 vb=8000k; then
        echo >&2 "[!] Fallback render failed"
        exit 1
    fi
fi

# ======================
# 8. VERIFY OUTPUT
# ======================
if [ ! -f "final_output.mp4" ]; then
    echo >&2 "[!] Final output not created"
    exit 1
fi

echo -e "\n=== RENDER COMPLETE ==="
echo "Output file: $JOB_FOLDER/final_output.mp4"
echo "Size: $(du -h "final_output.mp4" | cut -f1)"
echo "Duration: $(ffprobe -v error -show_entries format=duration \
    -of default=noprint_wrappers=1:nokey=1 "final_output.mp4" | xargs printf "%.1fs\n")"

exit 0

# Verify output quality
if [ $(du -k "final_output.mp4" | cut -f1) -lt 2000 ]; then
    echo "WARNING: Output file seems too small (effects may not have rendered)"
fi

ffprobe -v error -show_streams "final_output.mp4" | grep -E "codec_name|duration"

# If normal render fails, try alternative method
if [ ! -f "final_output.mp4" ] || [ $(du -k "final_output.mp4" | cut -f1) -lt 2000 ]; then
    echo "Trying alternative rendering method..."
    ffmpeg -loop 1 -i generated.jpg -i dummy_silence.wav \
        -vf "frei0r=kaleidoscope:0.5|0.5|0.5" \
        -c:v libx264 -crf 18 -preset slow -pix_fmt yuvj420p \
        -c:a aac -b:a 128k -shortest \
        -t 24 final_output_fallback.mp4
    mv final_output_fallback.mp4 final_output.mp4
fi

# Enhanced output verification
echo -e "\n=== OUTPUT VERIFICATION ==="
if [ ! -f "final_output.mp4" ]; then
    echo "ERROR: No output file created"
    exit 1
fi

FILESIZE=$(du -k "final_output.mp4" | cut -f1)
DURATION=$(ffprobe -v error -show_entries format=duration -of default=nw=1:nk=1 "final_output.mp4")
EFFECTS=$(ffprobe -v error -show_frames "final_output.mp4" | grep -c "pict_type=I")

echo "File size: ${FILESIZE}KB"
echo "Duration: ${DURATION}s"
echo "Keyframes: ${EFFECTS}"

if (( $(echo "$FILESIZE < 2000" | bc -l) )); then
    echo "WARNING: Output file too small - effects may not have rendered"
    exit 1
fi

# FFmpeg fallback if primary render fails
if [ ! -f "final_output.mp4" ] || [ $(du -k "final_output.mp4" | cut -f1) -lt 2000 ]; then
    echo "Using FFmpeg fallback rendering..."
    ffmpeg -loop 1 -i generated.jpg -i dummy_silence.wav \
        -vf "frei0r=glow,scale=1920:1080:flags=lanczos,frei0r=kaleidoscope" \
        -c:v libx264 -crf 16 -preset slow -pix_fmt yuv420p \
        -c:a aac -b:a 192k -shortest \
        -t 24 final_output.mp4
fi
