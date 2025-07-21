#!/usr/bin/env python3
import os
import sys
import xml.etree.ElementTree as ET

INPUT_PROJECT = "effects_template_base.kdenlive"
OUTPUT_PROJECT = "effects_template_stripped.kdenlive"

print(f"[+] Loading: {INPUT_PROJECT}")
tree = ET.parse(INPUT_PROJECT)
root = tree.getroot()

# Map producer id to file path
producer_paths = {}
for prod in root.findall(".//producer"):
    pid = prod.get("id")
    path = prod.findtext("property[@name='resource']")
    if pid and path:
        producer_paths[pid] = path

# Detect bad paths
bad_producers = {
    pid for pid, path in producer_paths.items()
    if not os.path.exists(path)
}

print(f"[✓] Found {len(bad_producers)} bad producers...")

# Remove bad producers
for prod in root.findall(".//producer"):
    if prod.get("id") in bad_producers:
        root.remove(prod)

# Remove all entries referencing those producers
for playlist in root.findall(".//playlist"):
    for entry in list(playlist.findall("entry")):
        if entry.get("producer") in bad_producers:
            playlist.remove(entry)

print(f"[✓] Saving cleaned project to: {OUTPUT_PROJECT}")
tree.write(OUTPUT_PROJECT, encoding="utf-8", xml_declaration=True)
