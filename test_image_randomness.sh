export JOB_ID="job_$(date +%s)"
python3 generate_rainbow_camouflage_contrast_hardedges.py
md5sum "jobs/$JOB_ID/current_abstract_video_image.jpg"
#!/bin/bash
set -e

cd "$(dirname "$0")"  # Ensure we run from script dir

echo "[*] Running image generation randomness test..."

NUM_RUNS=5
TEMP_DIR="jobs/randomness_test_$$"
mkdir -p "$TEMP_DIR"
MD5_FILE="$TEMP_DIR/md5s.txt"

> "$MD5_FILE"

for i in $(seq 1 $NUM_RUNS); do
    export JOB_ID="testjob_$i"
    echo "  → Run $i with JOB_ID=$JOB_ID"
    python3 generate_rainbow_camouflage_contrast_hardedges.py
md5sum "jobs/$JOB_ID/current_abstract_video_image.jpg"

    IMG="jobs/$JOB_ID/current_abstract_video_image.jpg"
    if [ ! -f "$IMG" ]; then
        echo "  ❌ Image not found: $IMG"
        exit 1
    fi

    SUM=$(md5sum "$IMG" | awk '{print $1}')
    echo "$SUM" >> "$MD5_FILE"
    cp "$IMG" "$TEMP_DIR/$i.jpg"
done

echo
echo "[*] Unique md5sums:"
sort "$MD5_FILE" | uniq -c

COUNT_UNIQUE=$(sort "$MD5_FILE" | uniq | wc -l)

if [ "$COUNT_UNIQUE" -eq "$NUM_RUNS" ]; then
    echo "[✓] All $NUM_RUNS images are unique!"
else
    echo "[!] Only $COUNT_UNIQUE of $NUM_RUNS images are unique. Not enough randomness?"
fi
