#!/usr/bin/env python3
import os
import sys
import shutil
import xml.etree.ElementTree as ET

TEMPLATE_PROJECT = "template_project.kdenlive"
PATCHED_PROJECT = "patched_render_final_nowav.kdenlive"

def log(msg):
    print(f"[+] {msg}")

def get_wav_producer_ids(root):
    """Find IDs of all <producer> elements with .wav resources."""
    wav_ids = set()
    for producer in root.findall(".//producer"):
        for prop in producer.findall("property"):
            if prop.get("name") == "resource" and ".wav" in (prop.text or ""):
                wav_ids.add(producer.attrib.get("id"))
    return wav_ids

def remove_wav_producers_and_entries(root, wav_ids):
    """Remove <producer> and <entry> elements referencing .wav IDs."""
    count_removed = 0

    # Remove wav producers
    for producer in list(root.findall(".//producer")):
        if producer.attrib.get("id") in wav_ids:
            root.remove(producer)
            count_removed += 1

    # Remove entries referencing those producers
    for playlist in root.findall(".//playlist"):
        for entry in list(playlist.findall("entry")):
            if entry.attrib.get("producer") in wav_ids:
                playlist.remove(entry)
                count_removed += 1

    return count_removed

def update_image_path(root, new_path):
    """Update any existing image resource path to the given path."""
    count_updated = 0
    for prop in root.findall(".//property"):
        if prop.get("name") == "resource" and prop.text and prop.text.endswith((".jpg", ".png")):
            prop.text = new_path
            count_updated += 1
    return count_updated

def patch_kdenlive_project(image_path):
    if not os.path.exists(TEMPLATE_PROJECT):
        print(f"[!] Missing template: {TEMPLATE_PROJECT}")
        sys.exit(1)

    shutil.copy(TEMPLATE_PROJECT, PATCHED_PROJECT)
    tree = ET.parse(PATCHED_PROJECT)
    root = tree.getroot()

    wav_ids = get_wav_producer_ids(root)
    removed = remove_wav_producers_and_entries(root, wav_ids)
    updated = update_image_path(root, image_path)

    tree.write(PATCHED_PROJECT, encoding="utf-8", xml_declaration=True)
    log(f"Saved patched file: {PATCHED_PROJECT}")
    log(f"Removed {removed} .wav producers and related entries")
    log(f"Updated {updated} image paths to: {image_path}")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 auto_patch_render_and_export.py /path/to/image.jpg")
        sys.exit(1)

    image_path = os.path.abspath(sys.argv[1])
    patch_kdenlive_project(image_path)
