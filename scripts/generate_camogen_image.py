"""
generate_camogen_image.py — Rainbow geometric camo pattern generator
Part of: Kaleidoscope Video Generator  (github.com/onojk/kaleido-video-generator)
"""

import os
import sys
import random
import numpy as np
from PIL import Image, ImageDraw

WIDTH, HEIGHT  = 1920, 1080
NUM_SHAPES     = int(os.getenv("NUM_SHAPES", "400"))
SHAPE_SIZE_MIN = 0.02
SHAPE_SIZE_MAX = 0.15
BLEED          = 0.3
LINE_WIDTH     = 12
DOT_RADIUS     = 12.5

COLOR_MAP = {
    "red":    (255, 0,   0),
    "orange": (255, 165, 0),
    "yellow": (255, 255, 0),
    "green":  (0,   255, 0),
    "blue":   (0,   0,   255),
    "indigo": (75,  0,   130),
    "violet": (238, 130, 238),
}

COLOR_NAMES = [
    c.strip()
    for c in os.getenv("COLORS", "red,orange,yellow,green").split(",")
    if c.strip() in COLOR_MAP
] or list(COLOR_MAP.keys())


def rainbow_color(_x, _y):
    return COLOR_MAP[random.choice(COLOR_NAMES)]


def generate_polygon(cx, cy, radius, sides):
    angle = random.uniform(0, 2 * np.pi)
    return [
        (
            int(cx + radius * np.cos(angle + 2 * np.pi * i / sides)),
            int(cy + radius * np.sin(angle + 2 * np.pi * i / sides)),
        )
        for i in range(sides)
    ]


def main():
    output_path = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else "camo.jpg")
    print(f"=== Camo generator | output={output_path} | colors={COLOR_NAMES} ===")

    img  = Image.new("RGB", (WIDTH, HEIGHT), (0, 0, 0))
    draw = ImageDraw.Draw(img)

    for _ in range(NUM_SHAPES):
        cx     = random.uniform(-BLEED, 1 + BLEED) * WIDTH
        cy     = random.uniform(-BLEED, 1 + BLEED) * HEIGHT
        radius = random.uniform(SHAPE_SIZE_MIN, SHAPE_SIZE_MAX) * WIDTH
        sides  = random.randint(3, 8)
        points = generate_polygon(cx, cy, radius, sides)
        color  = rainbow_color(cx, cy)

        draw.polygon(points, fill=color, outline="black")
        for i in range(len(points)):
            x1, y1 = points[i]
            x2, y2 = points[(i + 1) % len(points)]
            draw.line([x1, y1, x2, y2], fill="black", width=LINE_WIDTH)
        for x, y in points:
            draw.ellipse(
                [x - DOT_RADIUS, y - DOT_RADIUS, x + DOT_RADIUS, y + DOT_RADIUS],
                fill="black",
            )

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    img.save(output_path, quality=95)
    print(f"✅ Saved → {output_path}")


if __name__ == "__main__":
    main()
