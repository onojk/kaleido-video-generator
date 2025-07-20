#!/usr/bin/env python3
import numpy as np
from PIL import Image, ImageOps
import os

# === Output Path ===
OUTPUT_PATH = os.path.expanduser("~/kaleido_render_pipeline/current_abstract_video_image.jpg")

# === Image Size ===
WIDTH, HEIGHT = 3840, 2160  # 4K UHD

# === Generate RGB Stripes ===
def generate_rainbow_image(width, height):
    gradient = np.linspace(0, 255, width, dtype=np.uint8)
    stripes = np.tile(gradient, (height, 1))
    r = np.roll(stripes, 0, axis=1)
    g = np.roll(stripes, width // 3, axis=1)
    b = np.roll(stripes, 2 * width // 3, axis=1)
    return np.stack((r, g, b), axis=2)

# === Apply Max Contrast ===
def apply_max_contrast(image):
    return ImageOps.autocontrast(image, cutoff=0)

# === Generate, Save Image ===
def main():
    print("[*] Generating rainbow stripes...")
    rgb_data = generate_rainbow_image(WIDTH, HEIGHT)
    img = Image.fromarray(rgb_data, mode='RGB')
    img = apply_max_contrast(img)

    # Ensure output folder exists
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)

    img.save(OUTPUT_PATH, quality=95)
    print(f"[✓] Saved: {OUTPUT_PATH}")

if __name__ == "__main__":
    main()
