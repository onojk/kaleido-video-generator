#!/usr/bin/env python3
import os
import subprocess
import time

# === CONFIGURATION ===
BASE_DIR = "/home/onojk123/kaleido_render_pipeline"
GENERATE_SCRIPT = os.path.join(BASE_DIR, "rainbow_camouflage.py")
OUTPUT_IMAGE = os.path.join(BASE_DIR, "current_abstract_video_image.jpg")
TEMPLATE_KDENLIVE_FILE = os.path.join(BASE_DIR, "template_project.kdenlive")
RENDERED_KDENLIVE_FILE = os.path.join(BASE_DIR, "patched_project.kdenlive")
OUTPUT_VIDEO_FILE = os.path.join(BASE_DIR, "final_output_4k60.mp4")

# === STEP 1: Generate New Camouflage ===
def generate_camouflage():
    print("[+] Generating new camouflage image...")
    result = subprocess.run(["python3", GENERATE_SCRIPT])
    if result.returncode != 0 or not os.path.exists(OUTPUT_IMAGE):
        raise RuntimeError("Camouflage image generation failed")
    print(f"[+] Saved hard-edged camouflage: {OUTPUT_IMAGE}")

# === STEP 2: Patch Kdenlive Project File ===
def update_kdenlive_image_path():
    print("[+] Updating Kdenlive project file image path...")

    with open(TEMPLATE_KDENLIVE_FILE, "r") as infile:
        content = infile.read()

    # Replace any old path with the new one
    patched_content = content.replace(
        "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg",
        OUTPUT_IMAGE
    )

    with open(RENDERED_KDENLIVE_FILE, "w") as outfile:
        outfile.write(patched_content)

    print("[+] Kdenlive file patched.")

# === STEP 3: Render Using Flatpak's melt ===
def render_video():
    print("[+] Rendering video headlessly with Flatpak melt...")

    render_cmd = [
        "flatpak", "run", "--command=melt", "org.kde.kdenlive",
        RENDERED_KDENLIVE_FILE,
        "-profile", "atsc_2160p_60",  # 4K UHD 60fps
        "-consumer", f"avformat:{OUTPUT_VIDEO_FILE}",
        "vcodec=libx264", "acodec=aac", "b=20000k", "progressive=1"
    ]

    result = subprocess.run(render_cmd)

    if result.returncode != 0:
        raise RuntimeError("Video rendering failed")
    else:
        print(f"[+] Render complete: {OUTPUT_VIDEO_FILE}")

# === MAIN PIPELINE ===
def main():
    generate_camouflage()
    update_kdenlive_image_path()
    render_video()

if __name__ == "__main__":
    main()
