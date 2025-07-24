#!/usr/bin/env python3

import xml.etree.ElementTree as ET
import os

# Constants
KDENLIVE_PROJECT = "patched_render.kdenlive"

print("[🧩] Scanning for broken audio producers...")

if not os.path.exists(KDENLIVE_PROJECT):
    print(f"[❌] File not found: {KDENLIVE_PROJECT}")
    exit(1)

tree = ET.parse(KDENLIVE_PROJECT)
root = tree.getroot()
producers = root.findall(".//producer")

removed = 0

for producer in producers:
    resource = producer.find("property[@name='resource']")
    if resource is not None and resource.text:
        path = resource.text.strip()
        if path.lower().endswith(".wav") and not os.path.exists(path):
            print(f"[🗑️] Removing missing WAV: {path}")
            root.remove(producer)
            removed += 1

if removed == 0:
    print("[✅] No missing audio producers found.")
else:
    tree.write(KDENLIVE_PROJECT)
    print(f"[✓] Removed {removed} missing audio producers.")
