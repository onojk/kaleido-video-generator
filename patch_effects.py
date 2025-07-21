#!/usr/bin/env python3
import sys
import xml.etree.ElementTree as ET

if len(sys.argv) != 2:
    print("Usage: patch_effects.py input.kdenlive")
    sys.exit(1)

INPUT = sys.argv[1]
tree = ET.parse(INPUT)
root = tree.getroot()

# Target all playlist entries (video clips)
for playlist in root.findall(".//playlist"):
    for entry in playlist.findall("entry"):
        # Add kaleidoscope
        kal = ET.Element("filter", {"id": "frei0r.kaleidoscope", "in": "0", "out": "599"})
        prop = ET.SubElement(kal, "property", {"name": "0"})
        prop.text = "7"  # symmetry
        entry.append(kal)

        # Add RGB shift
        rgb = ET.Element("filter", {"id": "frei0r.rgbnoise", "in": "0", "out": "599"})
        ET.SubElement(rgb, "property", {"name": "0"}).text = "0.3"
        entry.append(rgb)

        # Add 3D tilt (rotation Y)
        rot = ET.Element("filter", {"id": "affine", "in": "0", "out": "599"})
        ET.SubElement(rot, "property", {"name": "rotate_y"}).text = "25"
        entry.append(rot)

# Output file
OUTPUT = INPUT.replace(".kdenlive", "_with_effects.kdenlive")
tree.write(OUTPUT)
print(f"[🎨] Patched effects written to: {OUTPUT}")
