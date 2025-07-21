#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

INPUT = "effects_template_cleaned.kdenlive"
OUTPUT = "effects_template_cleaned_final.kdenlive"

def log(msg):
    print(f"[+] {msg}")

log(f"Loading project: {INPUT}")
tree = ET.parse(INPUT)
root = tree.getroot()

producers = root.findall(".//producer")
bad_ids = set()

# Step 1: Find bad producers
for prod in producers:
    props = prod.findall("property")
    for prop in props:
        if prop.get("name") == "resource":
            path = prop.text.strip()
            if not os.path.isfile(path):
                bad_id = prod.get("id")
                log(f"[✂] Removing bad producer: {bad_id} → {path}")
                bad_ids.add(bad_id)
                root.remove(prod)

# Step 2: Remove references to bad producers
for playlist in root.findall(".//playlist"):
    entries = playlist.findall("entry")
    for entry in entries:
        if entry.get("producer") in bad_ids:
            playlist.remove(entry)
            log(f"[✂] Removed playlist entry using {entry.get('producer')}")

for tractor in root.findall(".//tractor"):
    tracks = tractor.findall("track")
    for track in tracks:
        if track.get("producer") in bad_ids:
            tractor.remove(track)
            log(f"[✂] Removed tractor track using {track.get('producer')}")

tree.write(OUTPUT, encoding="utf-8", xml_declaration=True)
log(f"[✓] Cleaned project saved to: {OUTPUT}")
