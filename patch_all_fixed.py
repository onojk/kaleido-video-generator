#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import shutil
import sys
import os

SOURCE = "patched_render.kdenlive"
OUTPUT = "patched_render_final_effects.kdenlive"
IMAGE_PATH = "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg"
FRAME_LENGTH = 600  # 10s at 60fps

def main():
    if not os.path.exists(SOURCE):
        print(f"[!] Missing: {SOURCE}")
        return

    shutil.copyfile(SOURCE, OUTPUT)
    tree = ET.parse(OUTPUT)
    root = tree.getroot()

    # === Add image producer ===
    image_producer = ET.SubElement(root, "producer", id="image_track")
    ET.SubElement(image_producer, "property", name="resource").text = IMAGE_PATH
    ET.SubElement(image_producer, "property", name="mlt_service").text = "qimage"
    ET.SubElement(image_producer, "property", name="length").text = str(FRAME_LENGTH)
    ET.SubElement(image_producer, "property", name="eof").text = "pause"

    # === Add effects (filters) directly to tractor0 (overlay) ===
    tractor0 = root.find(".//tractor[@id='tractor0']")
    if tractor0 is None:
        print("[!] tractor0 not found")
        return

    # Trim tractor
    tractor0.set("out", "00:00:10.000")

    # Inject image_track
    ET.SubElement(tractor0, "track", {"producer": "image_track"})

    # Add example filters
    filters = [
        ("frei0r.kaleidoscope", {"number_of_arms": "6", "angle": "0.5"}),
        ("frei0r.rgbparade", {}),
        ("qtblend", {"rotate_center": "1", "distort": "1"}),
        ("movit.lift_gamma_gain", {"lift_r": "1.2", "gain_g": "1.2"}),
    ]
    for i, (svc, props) in enumerate(filters):
        f = ET.SubElement(tractor0, "filter", id=f"fx{i}")
        ET.SubElement(f, "property", name="mlt_service").text = svc
        for k, v in props.items():
            ET.SubElement(f, "property", name=k).text = v
        ET.SubElement(f, "property", name="in").text = "0"
        ET.SubElement(f, "property", name="out").text = str(FRAME_LENGTH - 1)

    # === Update all producers to limit duration ===
    for prod in root.findall(".//producer"):
        ET.SubElement(prod, "property", name="length").text = str(FRAME_LENGTH)

    # === Update master tractor (projectTractor) too ===
    projectTractor = root.find(".//tractor[@id='tractor2']")
    if projectTractor is not None:
        for t in projectTractor.findall("track"):
            t.set("out", "00:00:10.000")
        projectTractor.set("out", "00:00:10.000")

    # Write patched project
    tree.write(OUTPUT)
    print(f"[✓] Wrote patched project to {OUTPUT}")

if __name__ == "__main__":
    main()
