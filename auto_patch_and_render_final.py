#!/usr/bin/env python3
import os
import xml.etree.ElementTree as ET
import shutil
import subprocess

INPUT_FILE = "patched_render_final.kdenlive"
CLEANED_FILE = "patched_render_final_cleaned.kdenlive"
FINAL_OUTPUT = "final_output_cleaned.mp4"
MELT_CMD = [
    "flatpak", "run", "--command=melt", "org.kde.kdenlive",
    CLEANED_FILE, "-profile", "hd1080",
    "-consumer", f"avformat:{FINAL_OUTPUT}", "acodec=aac", "vcodec=libx264"
]

def log(msg):
    print(f"[+] {msg}")

def patch_effect_ids(tree):
    root = tree.getroot()
    changed = False
    ids = []

    for idx, filt in enumerate(root.findall(".//filter")):
        if 'id' in filt.attrib:
            old_id = filt.attrib['id']
            new_id = f"filter{idx}"
            filt.attrib['id'] = new_id
            ids.append(new_id)
            changed = True

    if changed:
        log(f"Patched effect IDs: {ids}")
    else:
        log("No effect IDs needed patching.")

def clean_broken_media(tree):
    root = tree.getroot()
    removed = 0

    for producer in root.findall(".//producer"):
        resource = producer.find("property[@name='resource']")
        if resource is not None and not os.path.exists(resource.text.strip()):
            log(f"Removing broken media: {resource.text.strip()}")
            parent = producer.getparent() if hasattr(producer, 'getparent') else root
            try:
                root.remove(producer)
            except:
                pass
            removed += 1

    return removed

def process_project():
    if not os.path.exists(INPUT_FILE):
        log(f"[!] Missing project file: {INPUT_FILE}")
        exit(1)

    shutil.copy(INPUT_FILE, CLEANED_FILE)
    tree = ET.parse(CLEANED_FILE)

    patch_effect_ids(tree)
    removed = clean_broken_media(tree)

    tree.write(CLEANED_FILE)
    log(f"Saved cleaned project to: {CLEANED_FILE}")
    log(f"Total broken media entries removed: {removed}")

def run_render():
    log("Rendering with melt...")
    subprocess.run(MELT_CMD, check=True)

if __name__ == "__main__":
    process_project()
    run_render()
