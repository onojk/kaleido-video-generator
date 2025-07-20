#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
import shutil

INPUT = "patched_render_final.kdenlive"
OUTPUT = "patched_render_final_nuked.kdenlive"
BACKUP = INPUT + ".bak"

def log(msg):
    print(f"[+] {msg}")

def contains_wav_text(elem):
    return any(".wav" in (t or "").lower() for t in [elem.text, elem.tail] + [p.text for p in elem.iter()])

def main():
    if not os.path.exists(INPUT):
        log(f"[!] Missing file: {INPUT}")
        return

    shutil.copy(INPUT, BACKUP)
    tree = ET.parse(INPUT)
    root = tree.getroot()

    removed = 0
    for parent in root.findall(".//*"):
        children = list(parent)
        for child in children:
            if contains_wav_text(child):
                parent.remove(child)
                removed += 1

    tree.write(OUTPUT)
    log(f"Saved aggressively cleaned file: {OUTPUT}")
    log(f"Removed {removed} nodes containing '.wav'")

if __name__ == "__main__":
    main()
