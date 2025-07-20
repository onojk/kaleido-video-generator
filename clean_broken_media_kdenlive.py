#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET

SOURCE_PROJECT = "patched_render_final.kdenlive"
OUTPUT_PROJECT = "patched_render_final_cleaned.kdenlive"

def log(msg): print(f"[+] {msg}")

if not os.path.exists(SOURCE_PROJECT):
    print(f"[!] File not found: {SOURCE_PROJECT}")
    exit(1)

tree = ET.parse(SOURCE_PROJECT)
root = tree.getroot()

# Find all producers with a file path
producers = root.findall(".//producer")
removed = 0

for producer in producers:
    for prop in producer.findall("property"):
        if prop.get("name") == "resource":
            path = prop.text
            if path and not os.path.exists(path):
                log(f"Removing broken file reference: {path}")
                root.remove(producer)
                removed += 1
                break

# Remove broken playlist entries
playlists = root.findall(".//playlist")
for playlist in playlists:
    entries = playlist.findall("entry")
    for entry in entries:
        if "producer" in entry.attrib:
            prod_id = entry.attrib["producer"]
            if not any(p.get("id") == prod_id for p in root.findall(".//producer")):
                playlist.remove(entry)
                removed += 1

tree.write(OUTPUT_PROJECT)
log(f"Saved cleaned project to: {OUTPUT_PROJECT}")
log(f"Total broken references removed: {removed}")
