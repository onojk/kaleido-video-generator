#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
import shutil

INPUT = "patched_render_final.kdenlive"
OUTPUT = "patched_render_final_noaudio.kdenlive"
BACKUP = INPUT + ".bak"

def log(msg):
    print(f"[+] {msg}")

def get_all_wav_producer_ids(tree):
    root = tree.getroot()
    wav_producers = set()

    for prod in root.findall(".//producer"):
        for prop in prod.findall("property"):
            if ".wav" in (prop.text or "").lower():
                wav_producers.add(prod.attrib.get("id"))
                break

    return wav_producers

def remove_producers(tree, ids):
    root = tree.getroot()
    count = 0
    for prod in root.findall(".//producer"):
        if prod.attrib.get("id") in ids:
            root.remove(prod)
            count += 1
    return count

def remove_entries(tree, ids):
    root = tree.getroot()
    count = 0
    for playlist in root.findall(".//playlist"):
        for entry in playlist.findall("entry"):
            if entry.attrib.get("producer") in ids:
                playlist.remove(entry)
                count += 1
    return count

def main():
    if not os.path.exists(INPUT):
        log(f"[!] Missing file: {INPUT}")
        return

    shutil.copy(INPUT, BACKUP)
    tree = ET.parse(INPUT)

    wav_ids = get_all_wav_producer_ids(tree)
    log(f"Found {len(wav_ids)} .wav producer IDs to remove")

    removed_prods = remove_producers(tree, wav_ids)
    removed_entries = remove_entries(tree, wav_ids)

    tree.write(OUTPUT)
    log(f"Saved cleaned file: {OUTPUT}")
    log(f"Removed {removed_prods} producers and {removed_entries} entries")

if __name__ == "__main__":
    main()
