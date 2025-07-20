#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os
import sys

INPUT_FILE = "patched_render_final.kdenlive"
OUTPUT_FILE = "patched_render_final_deepclean.kdenlive"
BROKEN_KEYWORDS = [".wav", "Untit", "black", "missing", "invalid", ".mp3", ".m4a"]
REMOVED = {"producers": 0, "playlist_entries": 0, "audio_tracks": 0}

def is_broken(elem):
    """Return True if this element likely references a broken file."""
    for kw in BROKEN_KEYWORDS:
        if kw in ET.tostring(elem, encoding='unicode'):
            return True
    return False

def deep_clean_project():
    if not os.path.exists(INPUT_FILE):
        print(f"[!] File not found: {INPUT_FILE}")
        sys.exit(1)

    tree = ET.parse(INPUT_FILE)
    root = tree.getroot()

    # Remove broken producers
    for prod in root.findall(".//producer"):
        if is_broken(prod):
            root.remove(prod)
            REMOVED["producers"] += 1

    # Remove broken playlist entries
    for playlist in root.findall(".//playlist"):
        for entry in list(playlist):
            if is_broken(entry):
                playlist.remove(entry)
                REMOVED["playlist_entries"] += 1

    # Remove entire audio tracks (if empty or invalid)
    for track in root.findall(".//track"):
        props = track.findall("property")
        for p in props:
            if p.get("name") == "track_type" and p.text == "audio":
                root.remove(track)
                REMOVED["audio_tracks"] += 1
                break

    tree.write(OUTPUT_FILE)
    print(f"[✓] Saved cleaned project to: {OUTPUT_FILE}")
    print(f"[−] Removed {REMOVED['producers']} producers, {REMOVED['playlist_entries']} entries, {REMOVED['audio_tracks']} audio tracks.")

if __name__ == "__main__":
    deep_clean_project()
