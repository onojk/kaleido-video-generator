#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET

INPUT_FILE = "effects_template_base.kdenlive"
OUTPUT_FILE = "effects_template_cleaned.kdenlive"

print("[*] Loading:", INPUT_FILE)
tree = ET.parse(INPUT_FILE)
root = tree.getroot()

bad_ids = set()
producers = root.findall(".//producer")

# First pass: Remove <producer> nodes pointing to missing files
for producer in producers:
    for prop in producer.findall("property"):
        if prop.attrib.get("name") == "resource":
            path = prop.text
            if path and not os.path.exists(path):
                bad_id = producer.attrib.get("id")
                if bad_id:
                    bad_ids.add(bad_id)
                root.remove(producer)
                print(f"[✂] Removed bad producer: {bad_id} ({path})")

# Second pass: Remove any <entry> in <playlist> that references a bad producer
for playlist in root.findall(".//playlist"):
    entries = playlist.findall("entry")
    for entry in entries:
        if entry.attrib.get("producer") in bad_ids:
            playlist.remove(entry)
            print(f"[✂] Removed entry for producer: {entry.attrib['producer']}")

tree.write(OUTPUT_FILE)
print(f"[✓] Saved cleaned template to: {OUTPUT_FILE}")
