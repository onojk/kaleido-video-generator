#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import shutil
import os

TEMPLATE = "template_project.kdenlive"
PATCHED = "patched_render_final.kdenlive"
IMAGE_PATH = "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg"
FPS = 60
DURATION = 10
FRAMES = FPS * DURATION

def log(msg): print(f"[+] {msg}")

def patch_kdenlive_bin_effects():
    if not os.path.exists(TEMPLATE):
        print(f"[!] Missing template: {TEMPLATE}")
        return

    shutil.copy(TEMPLATE, PATCHED)
    tree = ET.parse(PATCHED)
    root = tree.getroot()

    # === Step 1: Replace image path and set duration ===
    for prod in root.findall(".//producer"):
        for prop in prod.findall("property"):
            if prop.get("name") == "resource":
                prop.text = IMAGE_PATH
            if prop.get("name") == "length":
                prop.text = str(FRAMES)

    # === Step 2: Inject effects directly in bin producers ===
    for binclip in root.findall(".//bin//producer"):
        # Clean old filters
        for f in binclip.findall("filter"):
            binclip.remove(f)

        # 1. Kaleidoscope
        kal = ET.SubElement(binclip, "filter")
        ET.SubElement(kal, "property", name="mlt_service").text = "frei0r.kaleid0sc0pe"
        ET.SubElement(kal, "property", name="symmetry").text = "8"

        # 2. RGB Gain
        lift = ET.SubElement(binclip, "filter")
        ET.SubElement(lift, "property", name="mlt_service").text = "movit.lift_gamma_gain"
        ET.SubElement(lift, "property", name="lift_r").text = "0.05"
        ET.SubElement(lift, "property", name="lift_g").text = "0.05"
        ET.SubElement(lift, "property", name="lift_b").text = "0.05"

        # 3. 3D Transform Zoom
        zoom = ET.SubElement(binclip, "filter")
        ET.SubElement(zoom, "property", name="mlt_service").text = "affine"
        ET.SubElement(zoom, "property", name="rotate").text = "0"
        ET.SubElement(zoom, "property", name="scale").text = "1.3"

    tree.write(PATCHED)
    log(f"[✓] Saved effects-patched project → {PATCHED}")

if __name__ == "__main__":
    patch_kdenlive_bin_effects()
