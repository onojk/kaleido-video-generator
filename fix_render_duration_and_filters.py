#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os

# Load and parse the Kdenlive project
template = "patched_render.kdenlive"
tree = ET.parse(template)
root = tree.getroot()

# Set duration to 600 frames everywhere
for prod in root.findall(".//producer"):
    for prop in prod.findall("property"):
        if prop.get("name") == "length":
            prop.text = "600"
        if prop.get("name") == "resource":
            if "qimage" in prop.text:
                prop.text = prop.text.replace("qimage", "pixbuf")

# Remove broken filters that refer to missing audio like "NumberXX.wav"
filters_to_remove = []
for filt in root.findall(".//filter"):
    for prop in filt.findall("property"):
        if prop.get("name") == "resource" and "Number" in prop.text:
            filters_to_remove.append(filt)
for filt in filters_to_remove:
    root.remove(filt)

# Fix all playlist entries to range from frame 0 to 599
for playlist in root.findall(".//playlist"):
    for entry in playlist.findall("entry"):
        entry.set("in", "0")
        entry.set("out", "599")

# Add a silent audio track to fill 10 seconds
audio_producer = ET.SubElement(root, "producer", id="audio_silence")
ET.SubElement(audio_producer, "property", name="mlt_service").text = "avformat"
ET.SubElement(audio_producer, "property", name="resource").text = os.path.abspath("silent.wav")
ET.SubElement(audio_producer, "property", name="length").text = "600"
ET.SubElement(audio_producer, "property", name="eof").text = "pause"
ET.SubElement(audio_producer, "property", name="audio_index").text = "0"

# Add audio entry to every playlist
for playlist in root.findall(".//playlist"):
    audio_entry = ET.Element("entry", producer="audio_silence", in_="0", out="599")
    playlist.append(audio_entry)

# Save the modified file
tree.write(template)
print("[✓] Patched project to 600 frames, fixed filters, and added silent audio")
