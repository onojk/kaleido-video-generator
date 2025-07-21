#!/usr/bin/env python3
import os
import subprocess
import time
import signal
from PIL import Image

# === Configuration ===
TEMPLATE_KDENLIVE = "template_project.kdenlive"
PATCHED_KDENLIVE_FILE = "patched_render_dynamic.kdenlive"
DURATION_SECONDS = 10
IMAGE_INPUT = "current_abstract_video_image.jpg"

RESOLUTIONS = [
    ("270p", 480, 270),
    ("360p", 640, 360),
    ("480p", 854, 480),
    ("720p", 1280, 720),
    ("1080p", 1920, 1080),
    ("1440p", 2560, 1440),
    ("2160p", 3840, 2160),
]

# === Helper Functions ===

def log(msg): print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def check_virtualenv():
    if os.environ.get("VIRTUAL_ENV") is None:
        print("🟡 WARNING: You are not inside a virtual environment!\n")

def kill_existing_melt():
    log("[!] Checking for existing melt processes...")
    try:
        output = subprocess.check_output(["pgrep", "melt"]).decode().split()
        for pid in output:
            print(f"  [!] Killing melt process {pid}")
            os.kill(int(pid), signal.SIGKILL)
    except subprocess.CalledProcessError:
        print("  [✓] No existing melt processes found.")

def resize_image(width, height, output_file):
    log(f"[🖼️ ] Resizing to {width}x{height} → {output_file}")
    img = Image.open(IMAGE_INPUT)
    img = img.resize((width, height), Image.LANCZOS)
    img.save(output_file, "JPEG")

def patch_kdenlive(image_path, duration_frames):
    log(f"[📄] Patching {TEMPLATE_KDENLIVE} → {PATCHED_KDENLIVE_FILE}")
    with open(TEMPLATE_KDENLIVE, "r") as f:
        xml = f.read()
    xml = xml.replace("REPLACE_IMAGE_PATH", image_path)
    xml = xml.replace("REPLACE_DURATION", str(duration_frames))
    with open(PATCHED_KDENLIVE_FILE, "w") as f:
        f.write(xml)
    log(f"[✓] Patched saved to {PATCHED_KDENLIVE_FILE}")

def render_with_melt(output_file, width, height):
    log(f"[🎬] Rendering to {output_file} at profile width={width} height={height}...")
    render_cmd = [
        "melt",
        PATCHED_KDENLIVE_FILE,
        "-profile", f"{width}x{height}@60",
        "-consumer", f"avformat:{output_file}",
        "acodec=aac", "vcodec=libx264", "vb=20000k", "ab=128k",
    ]
    return subprocess.Popen(render_cmd)

def monitor_output_file(filename, interval=1):
    log("[📊] Watching file size...")
    try:
        while True:
            if os.path.exists(filename):
                size_mb = os.path.getsize(filename) / 1024 / 1024
                print(f"{filename}: {size_mb:.1f} MB")
            else:
                print(f"{filename}: 0.0 MB")
            time.sleep(interval)
    except KeyboardInterrupt:
        print("^C")
        log("[!] Interrupted. Killing render process...")

def run_render_ladder():
    check_virtualenv()

    for label, w, h in RESOLUTIONS:
        print(f"\n=== 🚀 Starting {label.upper()} Render ({w}x{h}) ===")
        kill_existing_melt()

        temp_image = f"temp_image_{label}.jpg"
        output_file = f"output_{label}.mp4"
        resize_image(w, h, temp_image)

        total_frames = DURATION_SECONDS * 60  # 60fps assumed
        patch_kdenlive(temp_image, total_frames)

        process = render_with_melt(output_file, w, h)

        try:
            monitor_output_file(output_file)
        except KeyboardInterrupt:
            process.kill()
            log(f"[✓] {label.upper()} Render interrupted.")

if __name__ == "__main__":
    run_render_ladder()
