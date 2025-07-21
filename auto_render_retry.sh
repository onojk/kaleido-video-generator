#!/bin/bash

# Ultimate Kdenlive Render Script with Debug & Env Fixes

# Config
TEMPLATE_PROJECT="render_this.kdenlive"
PATCHED_PROJECT="temp_render.kdenlive"
OUTPUT_FILE="output_$(date +%Y%m%d-%H%M%S).mp4"
MAX_ATTEMPTS=3
FPS=60
MIN_DURATION_DIFF=0.5  # seconds
TIMEOUT_MULTIPLIER=6   # Timeout = duration * multiplier in seconds

cleanup() {
    [[ -f "$PATCHED_PROJECT" ]] && rm -f "$PATCHED_PROJECT"
    [[ -f "render.log" ]] && rm -f "render.log"
}

error_exit() {
    echo "ERROR: $1" >&2
    cleanup
    exit 1
}

verify_dependencies() {
    command -v flatpak >/dev/null 2>&1 || error_exit "Flatpak not installed"
    flatpak list | grep -q org.kde.kdenlive || error_exit "Kdenlive flatpak not found"
    command -v ffprobe >/dev/null 2>&1 || error_exit "ffprobe (ffmpeg) not installed"
    command -v xmlstarlet >/dev/null 2>&1 || error_exit "xmlstarlet not installed"
}

get_duration() {
    while true; do
        read -rp "⏱️ Enter exact duration in seconds (e.g., 10.0): " duration
        if [[ "$duration" =~ ^[0-9]+(\.[0-9]+)?$ ]] && \
           (( $(echo "$duration > 0" | bc -l) )) && \
           (( $(echo "$duration <= 3600" | bc -l) )); then
            echo "$duration"
            return
        fi
        echo "Invalid input. Enter positive number ≤ 3600 (e.g., 10.0)"
    done
}

patch_project() {
    local duration=$1
    local frames
    frames=$(echo "$duration * $FPS" | bc | awk '{printf "%.0f\n", $1}')

    echo "[🧩] Patching project with duration ${duration}s (${frames} frames @ ${FPS}fps)..."
    
    cp "$TEMPLATE_PROJECT" "$PATCHED_PROJECT" || error_exit "Failed copying template"
    
    # Patch duration in XML using xmlstarlet
    xmlstarlet ed -L \
      -u "/mlt/property[@name='out']" -v "$frames" \
      -u "/mlt/producer/property[@name='length']" -v "$frames" \
      -u "/mlt/producer/property[@name='out']" -v "$frames" \
      "$PATCHED_PROJECT" || error_exit "Failed patching project XML"
    
    # Confirm patching
    echo "Patched XML values:"
    xmlstarlet sel -t -m "/mlt" \
      -v "property[@name='out']" -o " (playlist out), " \
      -v "producer/property[@name='length']" -o " (producer length), " \
      -v "producer/property[@name='out']" -o " (producer out)" -n \
      "$PATCHED_PROJECT"
}

render_video() {
    local duration=$1
    local frames=$(echo "$duration * $FPS" | bc | awk '{printf "%.0f\n", $1}')
    local timeout=$(echo "$duration * $TIMEOUT_MULTIPLIER" | bc | awk '{printf "%.0f\n", $1}')

    echo "[🎬] Starting render (timeout: ${timeout}s)..."
    echo "[🔍] Full command being executed:"
    echo "flatpak run --filesystem=host --command=melt org.kde.kdenlive//stable \"$PATCHED_PROJECT\" -progress -consumer avformat:\"$OUTPUT_FILE\" vcodec=libx264 crf=18 preset=fast an=1 in=0 out=$frames"

    # Fix Flatpak env vars
    export XDG_DATA_DIRS=$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share

    flatpak run --filesystem=host --command=melt org.kde.kdenlive//stable \
        "$PATCHED_PROJECT" \
        -progress \
        -consumer avformat:"$OUTPUT_FILE" vcodec=libx264 crf=18 preset=fast an=1 in=0 out=$frames 2>&1 | tee render.log

    return ${PIPESTATUS[0]}
}
verify_duration() {
    local expected=$1
    local actual
    actual=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$OUTPUT_FILE" 2>/dev/null)

    if [[ -z "$actual" ]]; then
        echo "[⚠️] Could not verify output duration."
        return 1
    fi

    local diff
    diff=$(echo "sqrt(($actual - $expected)^2)" | bc -l)

    if (( $(echo "$diff < $MIN_DURATION_DIFF" | bc -l) )); then
        echo "[✅] Duration verified: ${actual}s (expected: ${expected}s)"
        return 0
    else
        echo "[⚠️] Duration mismatch: ${actual}s (expected: ${expected}s)"
        return 1
    fi
}

# Main
verify_dependencies
DURATION=$(get_duration)

trap cleanup EXIT
trap "error_exit 'Script interrupted.'" INT TERM

attempt=1
while (( attempt <= MAX_ATTEMPTS )); do
    echo -e "\n=== Attempt $attempt/$MAX_ATTEMPTS ==="
    
    [[ -f "$OUTPUT_FILE" ]] && rm -f "$OUTPUT_FILE"
    
    patch_project "$DURATION"
    if render_video "$DURATION"; then
        if verify_duration "$DURATION"; then
            echo -e "\n🎉 SUCCESS: Created video: $OUTPUT_FILE"
            echo "File size: $(du -h "$OUTPUT_FILE" | cut -f1)"
            exit 0
        fi
    fi
    
    echo "[⚠️] Render attempt $attempt failed, retrying..."
    ((attempt++))
    sleep 2
done

error_exit "Failed after $MAX_ATTEMPTS attempts."
