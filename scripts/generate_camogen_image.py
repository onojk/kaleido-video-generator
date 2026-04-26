"""
generate_camogen_image.py — Psychedelic geometric camo pattern generator
Part of: Kaleidoscope Video Generator (github.com/onojk/kaleido-video-generator)
"""

import colorsys
import math
import os
import random
import sys

import numpy as np  # noqa: F401  (kept for dependency consistency)
from PIL import Image, ImageDraw

WIDTH  = 1920
HEIGHT = 1080
BLEED  = 0.3

COLOR_MAP = {
    "red":    (255,   0,   0),
    "orange": (255, 165,   0),
    "yellow": (255, 255,   0),
    "green":  (  0, 255,   0),
    "blue":   (  0,   0, 255),
    "indigo": ( 75,   0, 130),
    "violet": (238, 130, 238),
}

COLOR_NAMES = [
    c.strip()
    for c in os.getenv("COLORS", "red,orange,yellow,green").split(",")
    if c.strip() in COLOR_MAP
] or list(COLOR_MAP.keys())

NUM_SHAPES = int(os.getenv("NUM_SHAPES", "600"))


# ---------------------------------------------------------------------------
# Palette builder — 6 variants per base color
# ---------------------------------------------------------------------------

def build_palette(color_names):
    palette = []
    for name in color_names:
        r, g, b = COLOR_MAP[name]
        # base
        palette.append((r, g, b))
        # two darker shades
        palette.append((int(r * 0.4), int(g * 0.4), int(b * 0.4)))
        palette.append((int(r * 0.7), int(g * 0.7), int(b * 0.7)))
        # two lighter tints (blend toward white)
        palette.append((
            int(r + (255 - r) * 0.6),
            int(g + (255 - g) * 0.6),
            int(b + (255 - b) * 0.6),
        ))
        palette.append((
            int(r + (255 - r) * 0.8),
            int(g + (255 - g) * 0.8),
            int(b + (255 - b) * 0.8),
        ))
        # hue-shifted variant via colorsys
        h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
        h2 = (h + random.choice([-0.05, 0.05])) % 1.0
        r2, g2, b2 = colorsys.hsv_to_rgb(h2, min(1.0, s * 1.2), v)
        palette.append((int(r2 * 255), int(g2 * 255), int(b2 * 255)))
    return palette


# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def choose_outline(fill, palette):
    t = random.random()
    if t < 0.30:
        return None
    if t < 0.50:
        return (0, 0, 0)
    if t < 0.65:
        return (255, 255, 255)
    if t < 0.82:
        return tuple(max(0, int(c * 0.3)) for c in fill)
    return random.choice(palette)


def lighter(color, factor=0.5):
    r, g, b = color
    return (
        int(r + (255 - r) * factor),
        int(g + (255 - g) * factor),
        int(b + (255 - b) * factor),
    )


def reg_poly_pts(cx, cy, radius, sides):
    off = random.uniform(0, 2 * math.pi)
    return [
        (
            cx + radius * math.cos(off + 2 * math.pi * i / sides),
            cy + radius * math.sin(off + 2 * math.pi * i / sides),
        )
        for i in range(sides)
    ]


# ---------------------------------------------------------------------------
# Shape drawers — each returns (pts_or_None, fill_color)
# pts is returned for solid-polygon shapes so the offset double-draw can reuse it
# ---------------------------------------------------------------------------

def draw_polygon(draw, palette, cx, cy, radius):
    sides = random.randint(3, 11)
    pts = reg_poly_pts(cx, cy, radius, sides)
    fill = random.choice(palette)
    draw.polygon(pts, fill=fill, outline=choose_outline(fill, palette))
    return pts, fill


def draw_star(draw, palette, cx, cy, radius):
    points = random.randint(5, 12)
    inner_r = radius * random.uniform(0.25, 0.55)
    off = random.uniform(0, 2 * math.pi)
    pts = []
    for i in range(points * 2):
        r = radius if i % 2 == 0 else inner_r
        a = off + math.pi * i / points
        pts.append((cx + r * math.cos(a), cy + r * math.sin(a)))
    fill = random.choice(palette)
    draw.polygon(pts, fill=fill, outline=choose_outline(fill, palette))
    return pts, fill


def draw_blob(draw, palette, cx, cy, radius):
    n = random.randint(20, 40)
    off = random.uniform(0, 2 * math.pi)
    pts = []
    for i in range(n):
        a = off + 2 * math.pi * i / n
        perturb = random.uniform(0.60, 1.40)   # ±40 % inward/outward
        pts.append((cx + radius * perturb * math.cos(a),
                    cy + radius * perturb * math.sin(a)))
    fill = random.choice(palette)
    draw.polygon(pts, fill=fill, outline=choose_outline(fill, palette))
    return pts, fill


def draw_ellipse_shape(draw, palette, cx, cy, radius):
    rx = radius * random.uniform(0.4, 2.5)
    ry = radius * random.uniform(0.2, 1.2)
    rot = random.uniform(0, math.pi)
    cos_r, sin_r = math.cos(rot), math.sin(rot)
    n = 32
    pts = []
    for i in range(n):
        a = 2 * math.pi * i / n
        ex = rx * math.cos(a)
        ey = ry * math.sin(a)
        pts.append((cx + ex * cos_r - ey * sin_r,
                    cy + ex * sin_r + ey * cos_r))
    fill = random.choice(palette)
    draw.polygon(pts, fill=fill, outline=choose_outline(fill, palette))
    return pts, fill


def draw_lightning(draw, palette, cx, cy, radius):
    n_segs = random.randint(4, 10)
    pts = [(cx, cy)]
    angle = random.uniform(0, 2 * math.pi)
    for _ in range(n_segs):
        angle += random.uniform(-math.pi * 0.6, math.pi * 0.6)
        seg = random.uniform(0.3, 1.0) * radius
        pts.append((pts[-1][0] + seg * math.cos(angle),
                    pts[-1][1] + seg * math.sin(angle)))
    fill = random.choice(palette)
    draw.line(pts, fill=fill, width=random.randint(3, 8))
    return None, fill  # no pts reuse for line-only shapes


def draw_spiral(draw, palette, cx, cy, radius):
    n_dots = random.randint(15, 35)
    dot_r = random.uniform(2, 6)
    rotations = random.uniform(1.0, 3.0) * 2 * math.pi
    off = random.uniform(0, 2 * math.pi)
    fill = random.choice(palette)
    for i in range(n_dots):
        t = i / max(n_dots - 1, 1)
        a = off + t * rotations
        r = t * radius
        x = cx + r * math.cos(a)
        y = cy + r * math.sin(a)
        draw.ellipse([x - dot_r, y - dot_r, x + dot_r, y + dot_r], fill=fill)
    return None, fill


def draw_crosshatch(draw, palette, cx, cy, radius):
    n_rects = random.randint(4, 12)
    rot = random.uniform(0, math.pi)
    cos_r, sin_r = math.cos(rot), math.sin(rot)
    fill = random.choice(palette)
    hw = random.uniform(0.15, 0.45) * radius
    hh = random.uniform(0.05, 0.18) * radius
    for _ in range(n_rects):
        ox = random.uniform(-radius, radius)
        oy = random.uniform(-radius, radius)
        x0, y0 = cx + ox, cy + oy
        pts = [
            (x0 + hw * cos_r - hh * sin_r, y0 + hw * sin_r + hh * cos_r),
            (x0 - hw * cos_r - hh * sin_r, y0 - hw * sin_r + hh * cos_r),
            (x0 - hw * cos_r + hh * sin_r, y0 - hw * sin_r - hh * cos_r),
            (x0 + hw * cos_r + hh * sin_r, y0 + hw * sin_r - hh * cos_r),
        ]
        draw.polygon(pts, fill=fill)
    return None, fill


def draw_arc_shape(draw, palette, cx, cy, radius):
    rx = random.uniform(0.5, 1.5) * radius
    ry = random.uniform(0.3, 1.0) * radius
    start = random.randint(0, 360)
    extent = random.randint(45, 270)
    fill = random.choice(palette)
    width = random.randint(3, 14)
    draw.arc(
        [cx - rx, cy - ry, cx + rx, cy + ry],
        start=start, end=start + extent,
        fill=fill, width=width,
    )
    return None, fill


# ---------------------------------------------------------------------------
# Weighted shape dispatcher
# ---------------------------------------------------------------------------

_SHAPE_TABLE = [
    (draw_polygon,       0.22),
    (draw_star,          0.14),
    (draw_blob,          0.14),
    (draw_ellipse_shape, 0.14),
    (draw_lightning,     0.10),
    (draw_spiral,        0.06),
    (draw_crosshatch,    0.10),
    (draw_arc_shape,     0.10),
]

_CUMULATIVE = []
_acc = 0.0
for _fn, _w in _SHAPE_TABLE:
    _acc += _w
    _CUMULATIVE.append(_acc)
_FUNCS = [fn for fn, _ in _SHAPE_TABLE]


def _pick_fn():
    r = random.random()
    for i, cum in enumerate(_CUMULATIVE):
        if r < cum:
            return _FUNCS[i]
    return _FUNCS[-1]


def draw_shape(draw, palette, cx, cy, radius):
    pts, fill = _pick_fn()(draw, palette, cx, cy, radius)

    # ~18 % of solid-polygon shapes get a lighter offset echo for a glow effect
    if pts is not None and random.random() < 0.18:
        dx = random.randint(2, 5) * random.choice([-1, 1])
        dy = random.randint(2, 5) * random.choice([-1, 1])
        shifted = [(x + dx, y + dy) for x, y in pts]
        draw.polygon(shifted, fill=lighter(fill, random.uniform(0.3, 0.6)))


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    output_path = os.path.abspath(sys.argv[1] if len(sys.argv) > 1 else "camo.jpg")
    palette = build_palette(COLOR_NAMES)
    print(
        f"=== Camo gen | {output_path} | colors={COLOR_NAMES} "
        f"| palette={len(palette)} | shapes={NUM_SHAPES} ==="
    )

    img  = Image.new("RGB", (WIDTH, HEIGHT), (8, 4, 18))   # deep indigo-black bg
    draw = ImageDraw.Draw(img)

    # Three-pass layering: background → midground → foreground
    bg_n  = NUM_SHAPES // 4
    mid_n = NUM_SHAPES // 2
    fg_n  = NUM_SHAPES - bg_n - mid_n

    passes = [
        ("bg",  bg_n,  0.07, 0.22),   # large shapes
        ("mid", mid_n, 0.02, 0.09),   # medium shapes
        ("fg",  fg_n,  0.005, 0.04),  # small accent shapes
    ]

    for label, count, r_min, r_max in passes:
        print(f"    [{label}] {count} shapes (radius {r_min:.3f}–{r_max:.3f} × W)...")
        for _ in range(count):
            cx = random.uniform(-BLEED, 1 + BLEED) * WIDTH
            cy = random.uniform(-BLEED, 1 + BLEED) * HEIGHT
            radius = random.uniform(r_min, r_max) * WIDTH
            draw_shape(draw, palette, cx, cy, radius)

    os.makedirs(os.path.dirname(output_path) or ".", exist_ok=True)
    img.save(output_path, quality=95)
    print(f"✅ Saved → {output_path}")


if __name__ == "__main__":
    main()
