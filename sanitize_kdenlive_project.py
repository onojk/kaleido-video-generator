#!/usr/bin/env python3
import xml.etree.ElementTree as ET

project_file = "patched_render.kdenlive"

tree = ET.parse(project_file)
root = tree.getroot()

# Remove problematic "interlaced" encoding setting
for prop in root.findall(".//property[@name='force_progressive']"):
    prop.text = "1"

# Sanitize invalid tracks
for track in root.findall(".//track"):
    if "audio" in track.attrib.get("type", "").lower():
        root.find(".//playlist").remove(track)

# Save cleaned project
tree.write(project_file)
print("[🧼] Project sanitized for melt rendering.")
