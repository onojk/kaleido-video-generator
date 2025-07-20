#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

FPS = 60
DURATION_SECONDS = 10
FRAMES = FPS * DURATION_SECONDS

PROJECT_FILE = "template_project.kdenlive"
IMAGE_PATH = "current_abstract_video_image.jpg"

def build_template():
    root = ET.Element("mlt", attrib={"LC_NUMERIC": "C", "producer": "main_bin"})
    
    # Playlist and track
    playlist = ET.SubElement(root, "playlist", id="playlist0")
    entry = ET.SubElement(playlist, "entry", {"producer": "image_producer", "in": "0", "out": str(FRAMES-1)})
    
    tractor = ET.SubElement(root, "tractor", id="tractor0", title="Main Tractor")
    ET.SubElement(tractor, "track", producer="playlist0")
    ET.SubElement(tractor, "property", name="length").text = str(FRAMES)
    ET.SubElement(tractor, "property", name="global_feed").text = "1"

    # Image producer
    image = ET.SubElement(root, "producer", id="image_producer")
    ET.SubElement(image, "property", name="resource").text = IMAGE_PATH
    ET.SubElement(image, "property", name="mlt_service").text = "qimage"
    ET.SubElement(image, "property", name="length").text = str(FRAMES)
    ET.SubElement(image, "property", name="loop").text = "0"

    # Add kaleidoscope effect
    kaleido = ET.SubElement(image, "filter")
    ET.SubElement(kaleido, "property", name="mlt_service").text = "frei0r.kaleidoscope"
    ET.SubElement(kaleido, "property", name="symmetry").text = "6"  # Feel free to adjust symmetry

    # Add lift/gamma/gain effect
    gamma = ET.SubElement(image, "filter")
    ET.SubElement(gamma, "property", name="mlt_service").text = "movit.lift_gamma_gain"
    ET.SubElement(gamma, "property", name="lift_r").text = "0.2"
    ET.SubElement(gamma, "property", name="lift_g").text = "0.2"
    ET.SubElement(gamma, "property", name="lift_b").text = "0.2"

    # Add pan and zoom effect (via qtblend)
    panzoom = ET.SubElement(image, "filter")
    ET.SubElement(panzoom, "property", name="mlt_service").text = "qtblend"
    ET.SubElement(panzoom, "property", name="composite.rect").text = "0% 0% 130% 130%"
    ET.SubElement(panzoom, "property", name="rotate").text = "0"

    tree = ET.ElementTree(root)
    tree.write(PROJECT_FILE, encoding="utf-8", xml_declaration=True)
    print(f"[✓] Rebuilt {PROJECT_FILE} with all effects.")

if __name__ == "__main__":
    build_template()
