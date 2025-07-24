import sys, os
from xml.etree import ElementTree as ET

job_id = os.environ.get("JOB_ID")
if not job_id:
    print("Missing JOB_ID environment variable")
    sys.exit(1)

job_dir = os.path.join("jobs", job_id)
image_path = os.path.join(job_dir, "generated.jpg")
image_path = os.path.realpath(image_path)

template_path = "template_project.kdenlive"
output_path = os.path.join(job_dir, "patched.kdenlive")

tree = ET.parse(template_path)
root = tree.getroot()

# Patch image path and duration
duration_frames = 250
for producer in root.iter("producer"):
    if producer.get("id") == "image_producer":
        for prop in producer.findall("property"):
            if prop.get("name") == "resource":
                prop.text = image_path
            elif prop.get("name") == "length":
                prop.text = str(duration_frames)

for tractor in root.iter("tractor"):
    for prop in tractor.findall("property"):
        if prop.get("name") == "length":
            prop.text = str(duration_frames)

for entry in root.iter("entry"):
    entry.set("in", "0")
    entry.set("out", str(duration_frames - 1))

tree.write(output_path, encoding="utf-8", xml_declaration=True)
print(f"[🧾] Patched Kdenlive project saved to: {output_path}")
