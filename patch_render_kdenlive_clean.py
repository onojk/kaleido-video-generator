#!/usr/bin/env python3
import os
import sys
import shutil
import xml.etree.ElementTree as ET
from datetime import datetime

# === Settings ===
INPUT_KDENLIVE = "patched_render.kdenlive"   # Input file to clean
OUTPUT_KDENLIVE = "patched_render_10s_clean.kdenlive"
FPS = 60
DURATION_SECONDS = 10
TOTAL_FRAMES = DURATION_SECONDS * FPS
MAX_TIME = "00:00:09.983"
MAX_LENGTH = f"{TOTAL_FRAMES}"

# === Utility ===
def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

def patch_kdenlive_file():
    if not os.path.exists(INPUT_KDENLIVE):
        log(f"[!] Input file not found: {INPUT_KDENLIVE}")
        sys.exit(1)

    shutil.copyfile(INPUT_KDENLIVE, OUTPUT_KDENLIVE)
    tree = ET.parse(OUTPUT_KDENLIVE)
    root = tree.getroot()

    # Fix profile (resolution and framerate)
    for profile in root.findall(".//profile"):
        profile.set("width", "1280")
        profile.set("height", "720")
        profile.set("frame_rate_num", str(FPS))
        profile.set("frame_rate_den", "1")

    # Fix all in/out durations
    for elem in root.iter():
        if "out" in elem.attrib:
            elem.set("out", MAX_TIME)
        if "length" in elem.attrib:
            elem.set("length", MAX_TIME)
        if "duration" in elem.attrib:
            elem.set("duration", MAX_LENGTH)
        if "kdenlive:duration" in elem.attrib:
            elem.set("kdenlive:duration", MAX_TIME)

    # Remove audio filters
    removed = 0
    for track in root.findall(".//filter"):
        service = track.find("property[@name='mlt_service']")
        if service is not None and service.text in ["volume", "panner"]:
            parent = track.getparent() if hasattr(track, 'getparent') else None
            if parent is not None:
                parent.remove(track)
            else:
                # fallback: manually search and remove
                for parent_candidate in root.iter():
                    if track in list(parent_candidate):
                        parent_candidate.remove(track)
                        break
            removed += 1

    # Force no audio tracks
    for prop in root.findall(".//property[@name='kdenlive:sequenceproperties.hasAudio']"):
        prop.text = "0"

    # Save updated file
    tree.write(OUTPUT_KDENLIVE)
    log(f"[✓] Patched saved to {OUTPUT_KDENLIVE}")
    log(f"[–] Removed {removed} audio filters (volume/panner)")

# === Run ===
if __name__ == "__main__":
    log("🔧 Cleaning and patching .kdenlive project...")
    patch_kdenlive_file()
    log("✅ Done. Use this for efficient 10s rendering.")
