#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import shutil
import os

TEMPLATE = "template_project.kdenlive"
PATCHED = "patched_render_final_effects.kdenlive"
IMAGE_PATH = "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg"
FPS = 60
DURATION = 10
FRAMES = FPS * DURATION

def log(msg): print(f"[+] {msg}")

def patch_kdenlive():
    if not os.path.exists(TEMPLATE):
        print(f"[!] Template missing: {TEMPLATE}")
        return

    shutil.copy(TEMPLATE, PATCHED)
    tree = ET.parse(PATCHED)
    root = tree.getroot()

    # === Step 1: Replace image path ===
    for prod in root.findall(".//producer"):
        for prop in prod.findall("property"):
            if prop.get("name") == "resource":
                prop.text = IMAGE_PATH

    # === Step 2: Set project duration ===
    for tag in root.findall(".//property[@name='length']"):
        tag.text = str(FRAMES)

    # === Step 3: Inject effects in the timeline playlist ===
    for playlist in root.findall(".//playlist"):
        # Only patch the first one with a 'producer' entry (skip black backgrounds)
        if playlist.find("entry") is not None:
            # Remove existing filters
            for f in playlist.findall("filter"):
                playlist.remove(f)

            # Add kaleidoscope filter
            kal = ET.SubElement(playlist, "filter")
            ET.SubElement(kal, "property", name="mlt_service").text = "frei0r.kaleid0sc0pe"
            ET.SubElement(kal, "property", name="symmetry").text = "8"

            # Add lift/gain filter
            lift = ET.SubElement(playlist, "filter")
            ET.SubElement(lift, "property", name="mlt_service").text = "movit.lift_gamma_gain"
            ET.SubElement(lift, "property", name="lift_r").text = "0.1"
            ET.SubElement(lift, "property", name="lift_g").text = "0.1"
            ET.SubElement(lift, "property", name="lift_b").text = "0.1"

            # Add composite zoom
            zoom = ET.SubElement(playlist, "filter")
            ET.SubElement(zoom, "property", name="mlt_service").text = "qtblend"
            ET.SubElement(zoom, "property", name="composite.rect").text = "0% 0% 130% 130%"
            break  # Only patch first usable playlist

    tree.write(PATCHED)
    log(f"✅ Saved with effects: {PATCHED}")

if __name__ == "__main__":
    patch_kdenlive()
