#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET

TEMPLATE = "effects_template_base.kdenlive"
OUTPUT = "effects_template_nomusic.kdenlive"

def is_missing_or_audio(path):
    return (path.endswith(".wav") or not os.path.exists(path))

def log(msg):
    print(f"[+] {msg}")

tree = ET.parse(TEMPLATE)
root = tree.getroot()

# Collect producer IDs to remove
remove_ids = set()
for prod in root.findall(".//producer"):
    for prop in prod.findall("property"):
        if prop.get("name") == "resource":
            resource = prop.text.strip()
            if is_missing_or_audio(resource):
                pid = prod.get("id")
                remove_ids.add(pid)
                root.remove(prod)
                log(f"Removed producer: {pid} ({resource})")

# Remove entries in playlists that use removed producers
removed_entries = 0
for playlist in root.findall(".//playlist"):
    for entry in list(playlist.findall("entry")):
        if entry.get("producer") in remove_ids:
            playlist.remove(entry)
            removed_entries += 1

log(f"Removed {removed_entries} entries referencing missing producers")

# Remove empty playlists
removed_playlists = 0
for playlist in list(root.findall(".//playlist")):
    if not playlist.findall("entry"):
        root.remove(playlist)
        removed_playlists += 1

log(f"Removed {removed_playlists} empty playlists")

# Save cleaned XML
tree.write(OUTPUT, encoding="utf-8", xml_declaration=True)
log(f"Saved cleaned project: {OUTPUT}")
