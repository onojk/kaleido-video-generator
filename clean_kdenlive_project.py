#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import shutil

INPUT_FILE = "render_this.kdenlive"
OUTPUT_FILE = "render_this_cleaned.kdenlive"

print("[🧼] Cleaning up Kdenlive project...")

# Back up the original
shutil.copy(INPUT_FILE, INPUT_FILE + ".bak")

tree = ET.parse(INPUT_FILE)
root = tree.getroot()

# Remove invalid producers (missing resource or empty)
for producer in root.findall(".//producer"):
    resource = producer.find("property[@name='resource']")
    if resource is None or not resource.text or resource.text.strip() == "":
        print(f"[✂️] Removing broken producer: {ET.tostring(producer, encoding='unicode')[:60]}...")
        root.remove(producer)

# Remove broken playlists (with no entries)
for playlist in root.findall(".//playlist"):
    entries = playlist.findall("entry")
    if len(entries) == 0:
        print(f"[✂️] Removing empty playlist: {ET.tostring(playlist, encoding='unicode')[:60]}...")
        root.remove(playlist)

tree.write(OUTPUT_FILE, encoding="utf-8", xml_declaration=True)
print(f"[✓] Cleaned project saved to {OUTPUT_FILE}")
