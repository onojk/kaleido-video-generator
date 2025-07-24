#!/usr/bin/env python3

import xml.etree.ElementTree as ET
import os

PROJECT = "patched_render.kdenlive"

print("[🔧] Patching render profile to disable interlace...")

if not os.path.exists(PROJECT):
    print(f"[❌] File not found: {PROJECT}")
    exit(1)

tree = ET.parse(PROJECT)
root = tree.getroot()

changed = False
for prop in root.findall(".//property[@name='interlace']"):
    if prop.text.strip() != "0":
        print(f"[✂️] Changing interlace={prop.text} to interlace=0")
        prop.text = "0"
        changed = True

if changed:
    tree.write(PROJECT)
    print("[✅] Interlace disabled in render profile.")
else:
    print("[✓] Already set to progressive (interlace=0).")
