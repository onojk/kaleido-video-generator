#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import os
import re
import subprocess
import time
import signal

# === Configuration ===
TEMPLATE = "template_project.kdenlive"
OUTPUT = "patched_render_10s.kdenlive"
IMAGE_NAME = "current_abstract_video_image.jpg"
IMAGE_PATH = os.path.abspath(IMAGE_NAME)
DURATION_TIME = "00:00:09.983"
OUTPUT_VIDEO = "final_output_10s.mp4"
DURATION_FRAMES = 600

def kill_existing_melt():
    print("[!] Checking for existing melt processes...")
    try:
        output = subprocess.check_output(["pgrep", "-f", "flatpak.*melt"]).decode()
        for pid in output.strip().split("\n"):
            print(f"[!] Killing previous melt process: {pid}")
            os.kill(int(pid), signal.SIGKILL)
    except subprocess.CalledProcessError:
        print("[✓] No existing melt processes found.")

def patch_kdenlive():
    print(f"[+] Patching template: {TEMPLATE}")
    tree = ET.parse(TEMPLATE)
    root = tree.getroot()

    # Patch producer1
    for producer in root.findall(".//producer[@id='producer1']"):
        for prop in producer.findall("property"):
            name = prop.get("name")
            if name == "resource":
                print(f"[+] Setting image path → {IMAGE_PATH}")
                prop.text = IMAGE_PATH
            elif name in ("length", "kdenlive:duration"):
                print(f"[+] Setting duration → {DURATION_TIME}")
                prop.text = DURATION_TIME
            elif name == "ttl":
                prop.text = "25"

    # Patch entries
    for entry in root.findall(".//entry[@producer='producer1']"):
        print(f"[+] Trimming clip entry → {DURATION_TIME}")
        entry.set("out", DURATION_TIME)

    # Patch tractors
    for tractor in root.findall(".//tractor"):
        if tractor.get("out"):
            print(f"[+] Trimming tractor → {DURATION_TIME}")
            tractor.set("out", DURATION_TIME)

    # Patch tracks
    for track in root.findall(".//track"):
        if track.get("out"):
            print(f"[+] Trimming track → {DURATION_TIME}")
            track.set("out", DURATION_TIME)

    # Patch keyframes in filters
    for filt in root.findall(".//filter"):
        for prop in filt.findall("property"):
            if prop.text and re.search(r"\d{2}:\d{2}:\d{2}\.\d{3}=", prop.text):
                matches = re.findall(r"(00:\d{2}:\d{2}\.\d{3})=([^\s;]+)", prop.text)
                if matches:
                    print(f"[+] Trimming keyframes for: {prop.get('name')}")
                    prop.text = f"00:00:00.000={matches[0][1]};{DURATION_TIME}={matches[-1][1]}"

    tree.write(OUTPUT, encoding="utf-8", xml_declaration=True)
    print(f"[✓] Patched project written to: {OUTPUT}")

def render_and_watch():
    print("[+] Launching Flatpak melt render...")
    cmd = [
        "flatpak", "run", "--command=melt", "org.kde.kdenlive",
        OUTPUT,
        "-profile", "atsc_2160p_60",
        "-consumer", f"avformat:{OUTPUT_VIDEO}",
        "vcodec=libx264", "acodec=aac", "ab=192k"
    ]
    proc = subprocess.Popen(cmd)

    try:
        print("[📊] Watching file size...")
        while proc.poll() is None:
            if os.path.exists(OUTPUT_VIDEO):
                size = os.path.getsize(OUTPUT_VIDEO) / (1024 * 1024)
                print(f"[{time.strftime('%H:%M:%S')}] {OUTPUT_VIDEO}: {size:.1f} MB")
            else:
                print(f"[{time.strftime('%H:%M:%S')}] Waiting for output file...")
            time.sleep(1)
    except KeyboardInterrupt:
        print("[!] Interrupted. Killing render process...")
        proc.kill()
        exit(1)

    if proc.returncode == 0:
        print(f"[✓] Render complete: {OUTPUT_VIDEO}")
    else:
        print("[✖] Render failed.")

if __name__ == "__main__":
    kill_existing_melt()
    patch_kdenlive()
    render_and_watch()
