#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

INPUT_FILE = "patched_render_final.kdenlive"
OUTPUT_FILE = "patched_render_final_nowav.kdenlive"
WAV_KEYWORDS = [f"Number{str(i).zfill(2)}.wav" for i in range(1, 21)]

def nuke_wav_references():
    if not os.path.exists(INPUT_FILE):
        print(f"[!] File not found: {INPUT_FILE}")
        return

    tree = ET.parse(INPUT_FILE)
    root = tree.getroot()
    removed = 0

    def recursive_clean(parent):
        nonlocal removed
        for child in list(parent):
            if any(wav in ET.tostring(child, encoding="unicode") for wav in WAV_KEYWORDS):
                parent.remove(child)
                removed += 1
            else:
                recursive_clean(child)

    recursive_clean(root)
    tree.write(OUTPUT_FILE)
    print(f"[✓] Saved cleaned file: {OUTPUT_FILE}")
    print(f"[🧨] Nuked {removed} .wav-related XML nodes")

if __name__ == "__main__":
    nuke_wav_references()
