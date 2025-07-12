#!/usr/bin/env python3
from PIL import Image
import os

# Disable Pillow’s decompression bomb protection
Image.MAX_IMAGE_PIXELS = None

# === Settings ===
INPUT_PATH = "rainbow_camouflage.jpg"
OUTPUT_PATH = "rainbow_camouflage_resized.jpg"
RESIZE_FACTOR = 0.25

def resize_large_image(input_path, output_path, factor):
    print(f"[+] Opening image: {input_path}")
    with Image.open(input_path) as img:
        new_size = (int(img.width * factor), int(img.height * factor))
        print(f"[+] Resizing to {new_size}")
        img = img.resize(new_size, Image.LANCZOS)
        img = img.convert("RGB")
        img.save(output_path, quality=90, optimize=True)
        print(f"[✓] Saved: {output_path}")

if __name__ == "__main__":
    if not os.path.exists(INPUT_PATH):
        print(f"[!] File not found: {INPUT_PATH}")
    else:
        resize_large_image(INPUT_PATH, OUTPUT_PATH, RESIZE_FACTOR)
