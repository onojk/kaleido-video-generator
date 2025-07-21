#!/usr/bin/env python3
import xml.etree.ElementTree as ET

INPUT = "patched_render_final.kdenlive"
OUTPUT = "patched_render_final_fixed.kdenlive"

tree = ET.parse(INPUT)
root = tree.getroot()

# Check if playlist already exists
existing = root.find(".//playlist[@id='playlist0']")
if existing is None:
    # Insert new playlist
    playlist = ET.Element("playlist", id="playlist0")
    entry = ET.SubElement(playlist, "entry", producer="image_track")
    root.insert(0, playlist)

# Patch tractor0 to use playlist0
for tractor in root.findall(".//tractor[@id='tractor0']"):
    if tractor.find("track[@producer='playlist0']") is None:
        ET.SubElement(tractor, "track", producer="playlist0")

tree.write(OUTPUT, encoding="utf-8", xml_declaration=True)
print(f"[✓] Injected 'image_track' into playlist0 and tractor0 → {OUTPUT}")
