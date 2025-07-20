#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

INPUT_FILE = "patched_render_final_nowav.kdenlive"
OUTPUT_FILE = "patched_render_final_cleaned.kdenlive"

# Valid parent tags that can contain <property>
VALID_PROPERTY_PARENTS = {"producer", "filter", "tractor", "playlist", "transition", "profile"}

# Keywords for broken resources to purge
BROKEN_PATH_KEYWORDS = ["Untitdfgfdgsrtgedrtrled.jpg"]

def clean_kdenlive_xml():
    if not os.path.exists(INPUT_FILE):
        print(f"[!] Missing: {INPUT_FILE}")
        return

    tree = ET.parse(INPUT_FILE)
    root = tree.getroot()
    removed_properties = 0
    removed_broken_paths = 0

    def recursive_clean(parent):
        nonlocal removed_properties, removed_broken_paths
        for child in list(parent):
            tag = child.tag.lower()
            parent_tag = parent.tag.lower()

            if tag == "property" and parent_tag not in VALID_PROPERTY_PARENTS:
                parent.remove(child)
                removed_properties += 1
            elif any(bad in ET.tostring(child, encoding="unicode") for bad in BROKEN_PATH_KEYWORDS):
                parent.remove(child)
                removed_broken_paths += 1
            else:
                recursive_clean(child)

    recursive_clean(root)
    tree.write(OUTPUT_FILE)
    print(f"[✓] Cleaned: {OUTPUT_FILE}")
    print(f"[🧼] Removed {removed_properties} orphan <property> nodes")
    print(f"[🖼️ ] Removed {removed_broken_paths} broken path references")

if __name__ == "__main__":
    clean_kdenlive_xml()
