#!/usr/bin/env python3
import xml.etree.ElementTree as ET

# === Configuration ===
input_path = "patched_render_final_fixed.kdenlive"
output_path = "patched_render_final_effects.kdenlive"
effects = [
    "frei0r.kaleid0sc0pe",
    "frei0r.rgbsplit0r",
    "frei0r.bigsh0t_transform_360",
    "frei0r.distort0r"
]
start_frame = 0
end_frame = 599  # 10s at 60fps

# === Load XML ===
tree = ET.parse(input_path)
root = tree.getroot()

# === Find tractor0 ===
tractor0 = None
for tractor in root.findall(".//tractor"):
    if tractor.get("id") == "tractor0":
        tractor0 = tractor
        break

if not tractor0:
    print("[!] Could not find <tractor id='tractor0'>")
    exit(1)

# === Inject <filter> blocks ===
for effect_name in effects:
    filter_elem = ET.Element("filter")
    
    service = ET.SubElement(filter_elem, "property", name="mlt_service")
    service.text = effect_name

    start = ET.SubElement(filter_elem, "property", name="start")
    start.text = str(start_frame)

    end = ET.SubElement(filter_elem, "property", name="end")
    end.text = str(end_frame)

    # Optionally add kdenlive_id to match what Kdenlive GUI expects
    kid = ET.SubElement(filter_elem, "property", name="kdenlive_id")
    kid.text = effect_name

    tractor0.append(filter_elem)

# === Save updated XML ===
tree.write(output_path, encoding="utf-8", xml_declaration=True)
print(f"[✓] Injected {len(effects)} effects into tractor0 → {output_path}")
