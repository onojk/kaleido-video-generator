#!/usr/bin/env python3
import os
import sys
import shutil
import xml.etree.ElementTree as ET
from datetime import datetime

# === Constants ===
TEMPLATE = "template_project.kdenlive"
PATCHED = "patched_render_10s.kdenlive"
OUTPUT_RES_X = 1280
OUTPUT_RES_Y = 720
FPS = 60
DURATION_SECONDS = 10
AUDIO_TRACK_TAGS = ["audio", "audiotrack"]

def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

def patch_kdenlive_template():
    if not os.path.exists(TEMPLATE):
        log(f"[ERROR] Missing {TEMPLATE}")
        sys.exit(1)

    shutil.copyfile(TEMPLATE, PATCHED)
    log(f"[✓] Copied {TEMPLATE} → {PATCHED}")

    tree = ET.parse(PATCHED)
    root = tree.getroot()

    # Adjust duration
    frames_total = int(DURATION_SECONDS * FPS)
    duration_str = f"{frames_total}"
    for playlist in root.findall(".//playlist"):
        if "duration" in playlist.attrib:
            playlist.set("duration", duration_str)

    # Set resolution and frame rate
    for profile in root.findall(".//profile"):
        profile.set("width", str(OUTPUT_RES_X))
        profile.set("height", str(OUTPUT_RES_Y))
        profile.set("frame_rate_num", str(FPS))
        profile.set("frame_rate_den", "1")

    # Remove all audio tracks
    tracks = root.findall(".//track")
    removed = 0
    for track in tracks:
        if track.get("type") == "audio":
            root.find(".//tractor").remove(track)
            removed += 1
    log(f"[–] Removed {removed} audio tracks")

    tree.write(PATCHED)
    log(f"[✓] Patched saved to {PATCHED}")

def main():
    log("🔧 Patching Kdenlive project for 10s, 1280x720, no audio...")
    patch_kdenlive_template()
    log("✅ Patch complete.")

if __name__ == "__main__":
    main()
