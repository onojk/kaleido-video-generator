#!/usr/bin/env python3
import xml.etree.ElementTree as ET

FILE = "patched_render.kdenlive"

tree = ET.parse(FILE)
root = tree.getroot()

count = 0
for prod in root.findall(".//producer"):
    interlace_found = False
    for prop in prod.findall("property"):
        if prop.get("name") == "interlace":
            prop.text = "0"
            interlace_found = True
            count += 1
    if not interlace_found:
        ET.SubElement(prod, "property", {"name": "interlace"}).text = "0"
        count += 1

tree.write(FILE)
print(f"[🧩] Patched {FILE}: interlace=0 set on {count} producers")
