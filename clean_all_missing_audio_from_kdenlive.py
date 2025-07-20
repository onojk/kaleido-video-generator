#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
import shutil

INPUT = "patched_render_final.kdenlive"
OUTPUT = "patched_render_final_noaudio.kdenlive"
BACKUP = INPUT + ".bak"

def log(msg):
    print(f"[+] {msg}")

def remove_missing_audio_producers(tree):
    root = tree.getroot()
    removed_ids = set()

    for prod in root.findall(".//producer"):
        resource = prod.find("property[@name='resource']")
        if resource is not None:
            path = resource.text.strip()
            if path.endswith(".wav") and not os.path.exists(path):
                removed_ids.add(prod.attrib.get("id"))
                root.remove(prod)
                log(f"Removed missing audio producer: {path}")

    return removed_ids

def remove_playlist_entries(tree, removed_ids):
    root = tree.getroot()
    count = 0
    for playlist in root.findall(".//playlist"):
        entries = playlist.findall("entry")
        for entry in entries:
            if 'producer' in entry.attrib and entry.attrib['producer'] in removed_ids:
                playlist.remove(entry)
                count += 1
    return count

def main():
    if not os.path.exists(INPUT):
        log(f"Missing file: {INPUT}")
        return

    shutil.copy(INPUT, BACKUP)
    tree = ET.parse(INPUT)

    removed_ids = remove_missing_audio_producers(tree)
    count = remove_playlist_entries(tree, removed_ids)

    tree.write(OUTPUT)
    log(f"Saved cleaned file: {OUTPUT}")
    log(f"Removed {len(removed_ids)} producers and {count} playlist entries")

if __name__ == "__main__":
    main()
