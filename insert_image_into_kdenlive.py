#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
from datetime import datetime

# === Config ===
KDENLIVE_INPUT = "cleaned_fully_stripped_project.kdenlive"
KDENLIVE_OUTPUT = "patched_with_image.kdenlive"
IMAGE_PATH = "/home/onojk123/kaleido-video-generator/temp_image_270p.jpg"  # ✅ Updated path
IMAGE_PRODUCER_ID = "new_image"
FPS = 60
DURATION_FRAMES = 600  # 10 seconds

def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

def insert_image(tree):
    root = tree.getroot()

    # Add <producer> for the image
    prod = ET.SubElement(root, "producer", id=IMAGE_PRODUCER_ID)
    ET.SubElement(prod, "property", name="resource").text = IMAGE_PATH
    ET.SubElement(prod, "property", name="mlt_service").text = "qimage"
    ET.SubElement(prod, "property", name="length").text = str(DURATION_FRAMES)
    ET.SubElement(prod, "property", name="eof").text = "pause"
    ET.SubElement(prod, "property", name="aspect_ratio").text = "1"
    ET.SubElement(prod, "property", name="seekable").text = "1"
    ET.SubElement(prod, "property", name="progressive").text = "1"

    # Find the first <playlist> and add an <entry>
    playlist = root.find(".//playlist")
    if playlist is None:
        log("[!] No <playlist> found — aborting.")
        return tree

    entry = ET.SubElement(playlist, "entry", {
        "producer": IMAGE_PRODUCER_ID,
        "in": "0",
        "out": str(DURATION_FRAMES - 1)
    })
    ET.SubElement(entry, "property", name="kdenlive:id").text = "999"

    return tree

def main():
    if not os.path.exists(IMAGE_PATH):
        log(f"[!] Image not found: {IMAGE_PATH}")
        return

    if not os.path.exists(KDENLIVE_INPUT):
        log(f"[!] Kdenlive project missing: {KDENLIVE_INPUT}")
        return

    tree = ET.parse(KDENLIVE_INPUT)
    tree = insert_image(tree)
    tree.write(KDENLIVE_OUTPUT)

    log(f"[✓] New image inserted into: {KDENLIVE_OUTPUT}")
    log("[🎬] You can now render it with melt.")

if __name__ == "__main__":
    main()
