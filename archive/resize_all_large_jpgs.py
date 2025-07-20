#!/usr/bin/env python3
import os
from PIL import Image

# Allow opening extremely large images
Image.MAX_IMAGE_PIXELS = None

RESIZE_FACTOR = 0.25
MAX_SAFE_PIXELS = 178956970  # PIL's original DecompressionBomb limit

def resize_if_large(image_path):
    try:
        with Image.open(image_path) as img:
            w, h = img.size
            total_pixels = w * h

            if total_pixels > MAX_SAFE_PIXELS:
                print(f"[+] Resizing {image_path} ({w}x{h})...")
                new_size = (int(w * RESIZE_FACTOR), int(h * RESIZE_FACTOR))
                img = img.resize(new_size, Image.LANCZOS)
                output_path = image_path.replace(".jpg", "_resized.jpg")
                img.save(output_path, quality=90, optimize=True)
                print(f"[✓] Saved: {output_path}")
            else:
                print(f"[=] Skipped (not oversized): {image_path}")
    except Exception as e:
        print(f"[!] Error processing {image_path}: {e}")

def main():
    for fname in os.listdir("."):
        if fname.lower().endswith(".jpg") and "_resized" not in fname:
            resize_if_large(fname)

if __name__ == "__main__":
    main()
