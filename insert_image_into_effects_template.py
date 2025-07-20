#!/usr/bin/env python3
import sys
import xml.etree.ElementTree as ET
import shutil

if len(sys.argv) != 3:
    print("Usage: python3 insert_image_into_effects_template.py render_this_effects.kdenlive your_image.jpg")
    sys.exit(1)

template_path = sys.argv[1]
image_path = sys.argv[2]
output_path = "patched_with_image.kdenlive"

shutil.copy(template_path, output_path)
tree = ET.parse(output_path)
root = tree.getroot()

patched = False
for prod in root.findall(".//producer"):
    for prop in prod.findall("property"):
        if prop.get("name") == "resource":
            prop.text = image_path
            patched = True

if patched:
    tree.write(output_path)
    print(f"[🎨] Image inserted → {output_path}")
else:
    print("[!] No <resource> tag found. Could not patch.")
