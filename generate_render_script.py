# File: generate_render_script.py

import os
import sys

def generate_render_script(job_id, project_root):
    job_dir = os.path.join(project_root, "jobs", job_id)
    os.makedirs(job_dir, exist_ok=True)
    script_path = os.path.join(job_dir, "render_video.sh")

    with open(script_path, "w") as f:
        f.write("#!/bin/bash\n")
        f.write("set -e\n")
        f.write(f"JOB_ID=\"{job_id}\"\n")
        f.write(f"PROJECT_ROOT=\"{project_root}\"\n")
        f.write("MLT_PATH=\"$PROJECT_ROOT/jobs/$JOB_ID/fixed.mlt\"\n")
        f.write("IMG_PATH=\"$PROJECT_ROOT/jobs/$JOB_ID/current_abstract_video_image.jpg\"\n")

        # Patch the MLT file
        f.write('sed -i "s|mlt_service=\\"[^\\"]*\\"|mlt_service=\\"qimage\\"|g" \"$MLT_PATH\"\n')
        f.write('sed -i "s|resource=\\"[^\\"]*\\"|resource=\\"$IMG_PATH\\"|g" \"$MLT_PATH\"\n')
        f.write('sed -i "s|<property name=\\"length\\">.*</property>|<property name=\\"length\\">600</property>|g" \"$MLT_PATH\"\n')

        # Render
        f.write("xvfb-run -a melt \"$MLT_PATH\" \\\n")
        f.write("  -profile hd1080p60 \\\n")
        f.write("  -consumer avformat:jobs/$JOB_ID/final_output_cleaned.mp4 \\\n")
        f.write("    vcodec=libx264 acodec=aac r=60 res=1920x1080 threads=2\n")

    os.chmod(script_path, 0o755)
    print(f"✅ render_video.sh created at: {script_path}")

# Allow CLI usage
if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python generate_render_script.py <JOB_ID> <PROJECT_ROOT>")
        sys.exit(1)

    job_id = sys.argv[1]
    project_root = sys.argv[2]
    generate_render_script(job_id, project_root)
