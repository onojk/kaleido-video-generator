import os
import math
import random
import numpy as np
from PIL import Image

# === Config ===
INPUT_PATH = "media/rainbow_grid_48000x2160.jpg"
OUTPUT_JPG = "media/distorted_rainbow_grid.jpg"
OUTPUT_SMALL_PNG = "media/distorted_rainbow_grid_small.png"
MAX_ANGLE = random.uniform(0.5, 2.5)
CENTER_JITTER = 0.2
DOWNSCALE_FACTOR = 4

Image.MAX_IMAGE_PIXELS = None  # Disable decompression bomb warning

def apply_radial_swirl_fast(img, angle_strength):
    width, height = img.size
    cx = width * (0.5 + random.uniform(-CENTER_JITTER, CENTER_JITTER))
    cy = height * (0.5 + random.uniform(-CENTER_JITTER, CENTER_JITTER))
    max_radius = math.hypot(cx, cy)

    # Prepare coordinate grids
    x = np.arange(width)
    y = np.arange(height)
    X, Y = np.meshgrid(x, y, indexing="xy")

    dx = X - cx
    dy = Y - cy
    radius = np.hypot(dx, dy)
    theta = np.where(radius == 0, 0, angle_strength * (radius / max_radius))
    angle = np.arctan2(dy, dx) + theta

    src_x = (cx + radius * np.cos(angle)).astype(np.int32)
    src_y = (cy + radius * np.sin(angle)).astype(np.int32)

    # Bound check
    mask = (src_x >= 0) & (src_x < width) & (src_y >= 0) & (src_y < height)

    src_pixels = np.array(img)
    dst_pixels = np.zeros_like(src_pixels)
    dst_pixels[mask] = src_pixels[src_y[mask], src_x[mask]]

    return Image.fromarray(dst_pixels)

def main():
    print(f"Loading input image: {INPUT_PATH}")
    img = Image.open(INPUT_PATH).convert("RGB")

    # Step 1: Downscale
    small_size = (img.width // DOWNSCALE_FACTOR, img.height // DOWNSCALE_FACTOR)
    img_small = img.resize(small_size, Image.LANCZOS)
    print(f"Downscaled to {small_size}, applying swirl distortion with angle ~{MAX_ANGLE:.2f}...")

    # Step 2: Swirl distortion
    distorted_small = apply_radial_swirl_fast(img_small, MAX_ANGLE)

    # Step 3: Save PNG for Upscayl
    distorted_small.save(OUTPUT_SMALL_PNG, "PNG")
    print(f"Saved: {OUTPUT_SMALL_PNG}")

    # Step 4: Optional preview full-size JPG
    distorted = distorted_small.resize(img.size, Image.BICUBIC)
    distorted.save(OUTPUT_JPG, "JPEG", quality=95, dpi=(72, 72))
    print(f"Saved preview JPG: {OUTPUT_JPG}")

if __name__ == "__main__":
    main()
