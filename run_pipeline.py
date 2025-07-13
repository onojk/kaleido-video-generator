#!/usr/bin/env python3
import subprocess
import os
import shutil
import time
import xml.etree.ElementTree as ET
from PIL import Image

# CONFIGURATION
IMAGE_NAME = "rainbow_camouflage_resized.jpg"
KDENLIVE_TEMPLATE = "render_this.kdenlive"
RENDERED_PROJECT = "patched_render.kdenlive"
FINAL_OUTPUT = "final_output.mp4"

def log(msg):
    print(f"[+] {msg}")

def run_script(script_name):
    log(f"Running: {script_name}")
    result = subprocess.run(["python3", script_name])
    if result.returncode != 0:
        print(f"[!] Script {script_name} failed.")
        exit(1)

def patch_kdenlive_project(image_path, duration):
    if not os.path.exists(KDENLIVE_TEMPLATE):
        print(f"[!] Missing template: {KDENLIVE_TEMPLATE}")
        exit(1)

    shutil.copy(KDENLIVE_TEMPLATE, RENDERED_PROJECT)
    tree = ET.parse(RENDERED_PROJECT)
    root = tree.getroot()

    modified = False

    # Update image path in producers
    for prod in root.findall(".//producer"):
        for prop in prod.findall("property"):
            if prop.get("name") == "resource" and IMAGE_NAME in prop.text:
                abs_path = os.path.abspath(image_path)
                if prop.text != abs_path:
                    log(f"Patching image path: {prop.text} → {abs_path}")
                    prop.text = abs_path
                    modified = True

                # Add 4 contrast filters
                existing_filters = prod.findall("filter[@id='brightness']")
                if len(existing_filters) < 4:
                    for _ in range(4):
                        filt = ET.Element("filter", attrib={
                            "id": "brightness",
                            "in": "00:00:00.000",
                            "out": "99:59:59.999"
                        })
                        ET.SubElement(filt, "property", name="brightness").text = "0"
                        ET.SubElement(filt, "property", name="contrast").text = "1.0"
                        ET.SubElement(filt, "property", name="saturation").text = "1.0"
                        prod.append(filt)
                    log("Injected 4 contrast filters (Kdenlive-style).")
                    modified = True

    # Update duration
    for prop in root.findall(".//property[@name='duration']"):
        old_val = prop.text
        prop.text = str(duration)
        if old_val != prop.text:
            log(f"Updated video duration: {old_val} → {prop.text}")
            modified = True

    if modified:
        tree.write(RENDERED_PROJECT)
        log("Kdenlive project file patched.")
    else:
        log("Image path already correct. No patch needed.")

def render_with_melt(duration):
    log("Rendering final video using Flatpak melt...")

    result = subprocess.run([
        "flatpak", "run", "--command=melt", "org.kde.kdenlive",
        RENDERED_PROJECT,
        "-consumer", f"avformat:{FINAL_OUTPUT}",
        "vcodec=libx264", "acodec=aac", "ab=192k",
        f"length={duration}"
    ])

    if result.returncode != 0:
        print("[+] ERROR: melt rendering failed.")
        exit(1)

# MAIN
log("Generating rainbow camouflage...")
run_script("generate_rainbow.py")

log("Applying GIMP-style max contrast...")
run_script("apply_max_contrast_final.py")

log("Resizing to 3840x2160...")
run_script("resize_large_image.py")

# Re-save JPG to ensure valid footer
img = Image.open(IMAGE_NAME)
img.save(IMAGE_NAME, quality=95)
log("Re-saved JPEG with proper footer: rainbow_camouflage_resized.jpg")

# Ask user for duration
try:
    user_seconds = int(input("[?] Enter video duration in seconds (1 to 3600): "))
    if not 1 <= user_seconds <= 3600:
        raise ValueError
except ValueError:
    print("[!] Invalid duration. Enter a number between 1 and 3600.")
    exit(1)

log("Checking .kdenlive project for image path...")
patch_kdenlive_project(IMAGE_NAME, user_seconds)

render_with_melt(user_seconds)
log(f"Done. Output video saved to: {FINAL_OUTPUT}")
