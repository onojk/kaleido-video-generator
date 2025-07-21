#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

SOURCE_FILE = "effects_template_base.kdenlive"
OUTPUT_FILE = "effects_template_cleaned.kdenlive"

def log(msg):
    print(msg)

def main():
    if not os.path.exists(SOURCE_FILE):
        print(f"[!] Missing {SOURCE_FILE}")
        return

    tree = ET.parse(SOURCE_FILE)
    root = tree.getroot()

    all_ids = set()
    used_ids = set()

    for e in root.iter():
        if "id" in e.attrib:
            all_ids.add(e.attrib["id"])
        for attr in e.attrib.values():
            if attr in all_ids:
                used_ids.add(attr)

    removed = 0
    for prod in root.findall(".//producer"):
        pid = prod.attrib.get("id", "")
        resource = prod.find("property[@name='resource']")
        res_path = resource.text if resource is not None else ""
        is_audio = res_path.lower().endswith((".wav", ".mp3"))
        if pid not in used_ids or is_audio:
            if resource is not None:
                print(f"🧹 Removing: {resource.text}")
            root.remove(prod)
            removed += 1

    print(f"[✓] Removed {removed} bad producers")

    # Remove empty playlists
    removed_playlists = 0
    for playlist in root.findall(".//playlist"):
        entries = playlist.findall("entry")
        if not entries:
            root.remove(playlist)
            removed_playlists += 1
    print(f"[✓] Removed {removed_playlists} empty playlists")

    tree.write(OUTPUT_FILE)
    print(f"[✓] Saved cleaned project: {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
