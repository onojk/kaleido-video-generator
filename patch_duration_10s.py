#!/usr/bin/env python3
import xml.etree.ElementTree as ET
from datetime import datetime

INPUT = "patched_with_image.kdenlive"
OUTPUT = "patched_render_final.kdenlive"
FPS = 60
FRAMES = 600
TIME_STR = "00:00:09.983"

def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

def patch_duration(tree):
    root = tree.getroot()
    for elem in root.iter():
        if "out" in elem.attrib:
            elem.set("out", TIME_STR)
        if "length" in elem.attrib:
            elem.set("length", TIME_STR)
        if "duration" in elem.attrib:
            elem.set("duration", str(FRAMES))
        for prop in elem.findall("property"):
            if prop.get("name") in ["kdenlive:duration", "length"]:
                prop.text = TIME_STR
    return tree

def main():
    tree = ET.parse(INPUT)
    tree = patch_duration(tree)
    tree.write(OUTPUT)
    log(f"[✓] Duration patched to 10s → {OUTPUT}")

if __name__ == "__main__":
    main()
