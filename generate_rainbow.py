import os
import random
from PIL import Image, ImageDraw

# === Output Settings ===
WIDTH = 48000
HEIGHT = 2160
CELL_SIZE = 120  # controls grid resolution
OUTPUT_DIR = "media"
OUTPUT_FILENAME = "rainbow_grid_48000x2160.jpg"
QUALITY = 90

def random_rainbow_color():
    import colorsys
    hue = random.random()
    r, g, b = colorsys.hsv_to_rgb(hue, 1.0, 1.0)
    return tuple(int(255 * c) for c in (r, g, b))

def generate_rainbow_grid():
    cols = WIDTH // CELL_SIZE
    rows = HEIGHT // CELL_SIZE
    img = Image.new("RGB", (WIDTH, HEIGHT), "black")
    draw = ImageDraw.Draw(img)

    for y in range(rows):
        for x in range(cols):
            color = random_rainbow_color()
            x0 = x * CELL_SIZE
            y0 = y * CELL_SIZE
            x1 = x0 + CELL_SIZE
            y1 = y0 + CELL_SIZE
            draw.rectangle([x0, y0, x1, y1], fill=color)

    return img

def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    path = os.path.join(OUTPUT_DIR, OUTPUT_FILENAME)
    img = generate_rainbow_grid()
    img.save(path, "JPEG", quality=QUALITY, dpi=(72, 72))
    print(f"Saved: {path}")

if __name__ == "__main__":
    main()
