#!/usr/bin/env python3
import os
import subprocess
import time
import shutil
import sys
from PIL import Image
from xml.etree import ElementTree as ET

# === CONFIG ===
SOURCE_IMAGE = "rainbow_camouflage_resized.jpg"
KDENLIVE_TEMPLATE = "template_project.kdenlive"
PATCHED_PROJECT = "patched_render_10s.kdenlive"
OUTPUT_VIDEO = "final_output_cleaned.mp4"
RENDER_DUR = 10
FPS = 60
WIDTH = 1280
HEIGHT = 720

def log(msg, icon="ℹ️"):
    print(f"[{icon}] {msg}")
    sys.stdout.flush()

def validate_mlt_services(kdenlive_path):
    tree = ET.parse(kdenlive_path)
    root = tree.getroot()
    mlt_services = set()

    # Collect all mlt_service attributes and warn if empty or broken
    for elem in root.findall(".//filter"):
        service = elem.find("property[@name='mlt_service']")
        if service is not None:
            mlt_services.add(service.text.strip())

    log("🧩 MLT Filters Found:")
    for svc in sorted(mlt_services):
        path_guess = f"./squashfs-root-new/usr/lib/mlt-7/{svc}.so"
        exists = os.path.exists(path_guess)
        status = "✅" if exists else "⚠️ MISSING"
        print(f"  - {svc:<30} {status}")
    print()

def clean_audio_tracks_and_patch(template_path, output_path, image_path):
    shutil.copy(template_path, output_path)
    tree = ET.parse(output_path)
    root = tree.getroot()
    duration_frames = RENDER_DUR * FPS

    # Remove any audio-related producers and tracks
    removed = 0
    for elem in root.findall(".//producer"):
        res = elem.find("property[@name='resource']")
        if res is not None and res.text and res.text.lower().endswith(".wav"):
            root.remove(elem)
            removed += 1
    for elem in root.findall(".//track"):
        if "audio" in elem.attrib.get("producer", "").lower():
            root.remove(elem)
            removed += 1
    if removed:
        log(f"Removed {removed} audio-related elements", "🧹")

    # Replace image path and length
    for elem in root.findall(".//producer"):
        for prop in elem.findall("property"):
            if prop.get("name") == "resource":
                prop.text = image_path
            elif prop.get("name") == "length":
                prop.text = str(duration_frames)

    for prop in root.findall(".//property[@name='length']"):
        prop.text = str(duration_frames)

    # Update resolution if applicable
    for elem in root.findall(".//profile"):
        elem.set("width", str(WIDTH))
        elem.set("height", str(HEIGHT))

    tree.write(output_path)
    log(f"Patched and cleaned project saved: {output_path}", "✓")

def render_mlt_project():
    cmd = [
        "./squashfs-root-new/usr/bin/melt",
        PATCHED_PROJECT,
        "-profile", "atsc_720p_30",
        "-consumer", f"avformat:{OUTPUT_VIDEO}",
        "vcodec=libx264", "acodec=aac"
    ]
    log(f"[🎬] Rendering with melt: {OUTPUT_VIDEO}")
    try:
        subprocess.run(cmd, check=True)
        log(f"[✅] Done rendering: {OUTPUT_VIDEO}")
    except subprocess.CalledProcessError as e:
        log(f"[❌] Melt rendering failed: {e}", "❌")
        sys.exit(1)

def main():
    if not os.path.exists(KDENLIVE_TEMPLATE):
        log(f"Missing {KDENLIVE_TEMPLATE}", "❌")
        sys.exit(1)
    if not os.path.exists(SOURCE_IMAGE):
        log(f"Missing source image: {SOURCE_IMAGE}", "❌")
        sys.exit(1)

    log("🔍 Validating MLT filters before render...")
    validate_mlt_services(KDENLIVE_TEMPLATE)

    log("🔧 Patching template and cleaning audio...")
    clean_audio_tracks_and_patch(KDENLIVE_TEMPLATE, PATCHED_PROJECT, os.path.abspath(SOURCE_IMAGE))

    log("🎥 Rendering video...")
    render_mlt_project()

if __name__ == "__main__":
    main()
