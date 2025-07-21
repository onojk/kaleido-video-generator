import os
import math
import random
import numpy as np
from PIL import Image, ImageDraw, ImageFilter

# === Settings ===
IMAGE_SIZE = (3500, 3500)
TILE_SIZE = 64  # smaller tiles = more distortions
OUTPUT_PATH = "media/distorted_rainbow_grid_small.png"
os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)


def hsv_to_rgb(h, s, v):
    """Convert HSV color to RGB (Pillow doesn't support HSV drawing natively)."""
    import colorsys
    return tuple(int(c * 255) for c in colorsys.hsv_to_rgb(h, s, v))


def generate_rainbow_tile(size):
    """Generate a rainbow tile."""
    img = Image.new("RGB", (size, size))
    draw = ImageDraw.Draw(img)

    for x in range(size):
        for y in range(size):
            h = (x + y) / (2 * size)
            color = hsv_to_rgb(h % 1.0, 1, 1)
            draw.point((x, y), fill=color)
    return img


def distort_tile(tile):
    """Apply a local swirl-like distortion to a tile."""
    tile_np = np.array(tile)
    h, w = tile_np.shape[:2]
    cx, cy = w // 2, h // 2

    result = np.zeros_like(tile_np)
    for y in range(h):
        for x in range(w):
            dx = x - cx
            dy = y - cy
            r = math.sqrt(dx * dx + dy * dy)
            angle = 0.03 * r  # Swirl strength

            src_x = int(cx + dx * math.cos(angle) - dy * math.sin(angle))
            src_y = int(cy + dx * math.sin(angle) + dy * math.cos(angle))

            if 0 <= src_x < w and 0 <= src_y < h:
                result[y, x] = tile_np[src_y, src_x]
            else:
                result[y, x] = tile_np[y, x]

    return Image.fromarray(result)


def build_distorted_grid():
    cols = IMAGE_SIZE[0] // TILE_SIZE
    rows = IMAGE_SIZE[1] // TILE_SIZE

    final = Image.new("RGB", IMAGE_SIZE)

    for i in range(cols):
        for j in range(rows):
            rainbow = generate_rainbow_tile(TILE_SIZE)
            distorted = distort_tile(rainbow)
            final.paste(distorted, (i * TILE_SIZE, j * TILE_SIZE))

    return final


if __name__ == "__main__":
    print("🎨 Generating dense rainbow distortion grid...")
    result = build_distorted_grid()
    result.save(OUTPUT_PATH, "PNG")
    print(f"✅ Saved: {OUTPUT_PATH}")
