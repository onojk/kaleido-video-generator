#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET

INPUT_PROJECT = "effects_template_base.kdenlive"
OUTPUT_PROJECT = "effects_template_nomusic.kdenlive"

print(f"[+] Loading project: {INPUT_PROJECT}")
tree = ET.parse(INPUT_PROJECT)
root = tree.getroot()

# Step 1: Collect all producer IDs linked to `.wav` files
music_producer_ids = set()

for producer in root.findall(".//producer"):
    resource = producer.findtext("property[@name='resource']")
    if resource and resource.lower().endswith(".wav"):
        pid = producer.get("id")
        if pid:
            music_producer_ids.add(pid)
            root.remove(producer)

print(f"[✓] Removed {len(music_producer_ids)} <producer> blocks for .wav files")

# Step 2: Collect <entry> tags referencing those producer IDs and remove them
entry_count = 0
for playlist in root.findall(".//playlist"):
    for entry in list(playlist.findall("entry")):
        if entry.get("producer") in music_producer_ids:
            playlist.remove(entry)
            entry_count += 1

print(f"[✓] Removed {entry_count} <entry> blocks referencing music producers")

# Step 3: Remove <track> or <playlist> with no entries left
track_count = 0
for playlist in root.findall(".//playlist"):
    if not playlist.findall("entry"):
        root.remove(playlist)
        track_count += 1

print(f"[✓] Removed {track_count} empty <playlist> tracks")

# Step 4: Extra cleanup: remove references to any wav paths in XML
orphan_resource_paths = 0
for prop in root.findall(".//property[@name='resource']"):
    if prop.text and prop.text.lower().endswith(".wav"):
        parent = prop.getparent() if hasattr(prop, "getparent") else None
        prop.text = ""
        orphan_resource_paths += 1

print(f"[✓] Removed {orphan_resource_paths} orphan .wav resource paths (if any)")

# Step 5: Save
tree.write(OUTPUT_PROJECT, encoding="utf-8", xml_declaration=True)
print(f"[✓] Saved cleaned project: {OUTPUT_PROJECT}")
