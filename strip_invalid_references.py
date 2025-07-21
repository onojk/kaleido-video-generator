#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
from datetime import datetime

INPUT = "cleaned_stripped_project.kdenlive"
OUTPUT = "cleaned_fully_stripped_project.kdenlive"

def log(msg):
    print(f"[{datetime.now().strftime('%H:%M:%S')}] {msg}")

def file_exists(path):
    return os.path.exists(path)

def remove_parents_with_invalid_resource(tree):
    root = tree.getroot()
    count = 0

    for parent in list(root.iter()):
        for prop in parent.findall("property"):
            if prop.get("name") == "resource":
                path = prop.text
                if path and not file_exists(path):
                    # Remove parent element from its grandparent
                    for grandparent in root.iter():
                        if parent in list(grandparent):
                            grandparent.remove(parent)
                            count += 1
                            break
                    break  # stop checking properties inside this element

    return count

def main():
    if not os.path.exists(INPUT):
        log(f"[!] Input file not found: {INPUT}")
        return

    tree = ET.parse(INPUT)
    removed = remove_parents_with_invalid_resource(tree)
    tree.write(OUTPUT)

    log(f"[✓] Saved cleaned file: {OUTPUT}")
    log(f"[–] Removed {removed} elements with broken resource paths")

if __name__ == "__main__":
    main()
