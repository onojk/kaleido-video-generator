#!/usr/bin/env python3
import numpy as np
from PIL import Image, ImageOps, ImageEnhance
import os
import time
from datetime import timedelta
import random

# === Configuration ===
WIDTH, HEIGHT = 48000, 2160
CHUNK_WIDTH = 2048
OCTAVES = (3, 6)
OUTPUT_FILE = "rainbow_camouflage_seamless.jpg"
TEMP_DIR = "tmp_seamless_chunks"
DPI = 72
CONTRAST_BOOST = 2.0

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def setup_temp_dir():
    os.makedirs(TEMP_DIR, exist_ok=True)
    for f in os.listdir(TEMP_DIR):
        os.remove(os.path.join(TEMP_DIR, f))

def generate_noise(height, width, seed):
    random.seed(seed)
    octaves = random.randint(*OCTAVES)
    scale = random.uniform(0.002, 0.005)
    noise = np.zeros((height, width))

    x = np.linspace(0, 2 * np.pi, width)
    y = np.linspace(0, 2 * np.pi, height)
    xv, yv = np.meshgrid(x, y)

    for o in range(octaves):
        freq = 2 ** o
        noise += (1/freq) * np.sin((xv + seed) * freq) * np.cos((yv + seed) * freq * 1.3)

    noise = (noise - noise.min()) / (noise.max() - noise.min())
    return noise

def noise_to_rainbow(noise, hue_center, hue_range):
    h = (noise * hue_range + hue_center) % 1.0
    s = np.ones_like(h) * 0.9
    v = np.power(noise, 0.3) * 0.8 + 0.2

    c = v * s
    x = c * (1 - np.abs((h * 6) % 2 - 1))
    m = v - c

    rgb = np.zeros((*h.shape, 3))

    regions = [
        ((0 <= h) & (h < 1/6), (c, x, np.zeros_like(h))),
        ((1/6 <= h) & (h < 1/3), (x, c, np.zeros_like(h))),
        ((1/3 <= h) & (h < 1/2), (np.zeros_like(h), c, x)),
        ((1/2 <= h) & (h < 2/3), (np.zeros_like(h), x, c)),
        ((2/3 <= h) & (h < 5/6), (x, np.zeros_like(h), c)),
        ((5/6 <= h) & (h <= 1), (c, np.zeros_like(h), x)),
    ]

    for condition, (r, g, b) in regions:
        stacked = np.stack([r, g, b], axis=-1)
        rgb[condition] = stacked[condition]

    return ((rgb + m[..., np.newaxis]) * 255).astype(np.uint8)

def save_chunk(chunk, x_offset):
    img = Image.fromarray(chunk)

    if x_offset > 0:
        prev_path = os.path.join(TEMP_DIR, f"chunk_{x_offset - CHUNK_WIDTH:06d}.jpg")
        if os.path.exists(prev_path):
            prev_img = Image.open(prev_path)
            if prev_img.size != img.size:
                prev_img = prev_img.resize(img.size)

            blend_width = min(64, img.width // 8)
            prev_right = prev_img.crop((prev_img.width - blend_width, 0, prev_img.width, prev_img.height))
            curr_left = img.crop((0, 0, blend_width, img.height))

            for x in range(blend_width):
                alpha = x / blend_width
                for y in range(img.height):
                    pr = prev_right.getpixel((x, y))
                    cl = curr_left.getpixel((x, y))
                    blended = tuple(int(pr[i] * (1 - alpha) + cl[i] * alpha) for i in range(3))
                    img.putpixel((x, y), blended)
            prev_img.close()

    img = ImageOps.autocontrast(img)
    img = ImageEnhance.Contrast(img).enhance(CONTRAST_BOOST)

    path = os.path.join(TEMP_DIR, f"chunk_{x_offset:06d}.jpg")
    img.save(path, quality=90, dpi=(DPI, DPI), optimize=True, progressive=True)
    return path

def assemble_image():
    final = Image.new('RGB', (WIDTH, HEIGHT))
    chunks = sorted(os.listdir(TEMP_DIR))
    for chunk_file in chunks:
        try:
            x = int(chunk_file.split('_')[1].split('.')[0])
            img = Image.open(os.path.join(TEMP_DIR, chunk_file))
            final.paste(img, (x, 0))
            img.close()
        except Exception as e:
            log(f"⚠️ Error processing {chunk_file}: {str(e)}")
    final.save(OUTPUT_FILE, quality=95, dpi=(DPI, DPI), optimize=True, progressive=True)
    return final.size

def generate_camouflage():
    start = time.time()
    setup_temp_dir()
    log(f"🚀 Generating {WIDTH:,}x{HEIGHT} seamless rainbow camouflage")

    base_seed = 42
    try:
        for i, x in enumerate(range(0, WIDTH, CHUNK_WIDTH)):
            chunk_w = min(CHUNK_WIDTH, WIDTH - x)
            log(f"🎨 Chunk {x:,}–{x+chunk_w:,} ({(x+chunk_w)/WIDTH*100:.1f}%)")

            random.seed(base_seed + i)
            noise = generate_noise(HEIGHT, chunk_w, base_seed + i)
            chunk = noise_to_rainbow(noise, random.uniform(0, 0.7), random.uniform(0.3, 0.5))
            save_chunk(chunk, x)

        log("🧩 Stitching chunks...")
        final_size = assemble_image()
        duration = timedelta(seconds=int(time.time() - start))
        log(f"\n✅ Done in {duration}")
        log(f"📐 Size: {final_size[0]:,}x{final_size[1]} px")
        log(f"📦 File: {os.path.getsize(OUTPUT_FILE)/1024/1024:.1f} MB")

    except KeyboardInterrupt:
        log("⚠️ Interrupted. Saving partial image...")
        if os.listdir(TEMP_DIR):
            assemble_image()
        raise

if __name__ == "__main__":
    generate_camouflage()
