#!/bin/bash
set -e

# 👣 Step 1: Activate virtual environment
source venv/bin/activate

# 🌀 Step 2: Generate a new rainbow camouflage image
echo "🎨 Generating abstract image..."
python3 generate_rainbow_camouflage_contrast_hardedges.py

# 🧠 Step 3: Set JOB_ID from newest job folder
export JOB_ID=$(ls -td jobs/*/ | head -1 | cut -d'/' -f2)
echo "🪪 JOB_ID = $JOB_ID"

# 🛠 Step 4: Generate new fixed.mlt using updated image
echo "📄 Building fixed.mlt..."
python3 generate_fixed_mlt.py \
  --input jobs/$JOB_ID/current_abstract_video_image.jpg \
  --output jobs/$JOB_ID/fixed.mlt

# 🧼 Optional: Patch MLT for frame count, resolution, or pause behavior
sed -i 's|<property name="length">.*</property>|<property name="length">600</property>|' jobs/$JOB_ID/fixed.mlt
sed -i '/<producer/,/<\/producer>/s|</producer>|  <property name="eof">pause</property>\n</producer>|' jobs/$JOB_ID/fixed.mlt

# 🎞 Step 5: Render final video
echo "🛠 Rendering cleaned video..."
xvfb-run -a melt jobs/$JOB_ID/fixed.mlt \
  -profile auto \
  -consumer avformat:jobs/$JOB_ID/final_output_cleaned.mp4 \
    res=1920x1080 \
    vcodec=libx264 acodec=aac threads=2 frame_rate_num=60 frame_rate_den=1

echo "✅ Done! MP4 ready at: jobs/$JOB_ID/final_output_cleaned.mp4"
