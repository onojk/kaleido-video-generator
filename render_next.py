#!/usr/bin/env python3
import os
import subprocess
import xml.etree.ElementTree as ET
import shutil
from datetime import datetime

TEMPLATE = "effects_template_base.kdenlive"
PATCHED = "patched_render_final.kdenlive"
RENDERED_IMAGE = "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg"
FINAL_OUTPUT = f"final_output_{datetime.now().strftime('%Y%m%d_%H%M%S')}.mp4"

def patch_project():
    if not os.path.exists(TEMPLATE):
        print(f"[!] Missing template: {TEMPLATE}")
        return False

    shutil.copy(TEMPLATE, PATCHED)
    tree = ET.parse(PATCHED)
    root = tree.getroot()

    if root.tag != "mlt":
        print("[!] Error: Root tag is not <mlt>")
        return False

    for prod in root.findall(".//producer"):
        if prod.attrib.get("id", "") == "image_track":
            root.remove(prod)

    new_prod = ET.SubElement(root, "producer", id="image_track")
    ET.SubElement(new_prod, "property", name="resource").text = RENDERED_IMAGE
    ET.SubElement(new_prod, "property", name="mlt_service").text = "qimage"
    ET.SubElement(new_prod, "property", name="length").text = "600"
    ET.SubElement(new_prod, "property", name="eof").text = "pause"

    tree.write(PATCHED)
    print(f"[✓] Project patched and saved: {PATCHED}")
    return True

def render_kdenlive_project():
    print("[🎬] Starting render via Flatpak melt...")

    cmd = [
        "flatpak", "run", "--command=melt", "org.kde.kdenlive",
        PATCHED,
        "-profile", "hd1080",
        "-consumer", f"avformat:{FINAL_OUTPUT}",
        "acodec=none"
    ]

    subprocess.run(cmd, check=True)

if __name__ == "__main__":
    if patch_project():
        render_kdenlive_project()
