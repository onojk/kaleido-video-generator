#!/usr/bin/env python3
import numpy as np
from PIL import Image, ImageOps, ImageEnhance
import os
import time
from datetime import timedelta
import random

# === Configuration ===
WIDTH, HEIGHT = 48000, 2160
CHUNK_WIDTH = 2048  # Must divide WIDTH evenly for best results
OCTAVES = (3, 6)
OUTPUT_FILE = "rainbow_camouflage_seamless.jpg"
TEMP_DIR = "tmp_seamless_chunks"
DPI = 72
CONTRAST_BOOST = 2.0  # 1.0 = normal, 2.0 = punchy

def timed_log(message):
    print(f"[{time.strftime('%H:%M:%S')}] {message}")

def setup_environment():
    os.makedirs(TEMP_DIR, exist_ok=True)
    for f in os.listdir(TEMP_DIR):
        os.remove(os.path.join(TEMP_DIR, f))

def generate_seamless_noise(height, width, x_offset, seed):
    """Generate sin/cos based tileable noise with radial wave"""
    octaves = random.randint(*OCTAVES)
    scale = random.uniform(0.002, 0.005)
    hue_center = random.uniform(0, 0.7)
    hue_range = random.uniform(0.3, 0.5)

    x = np.linspace(0, 2 * np.pi, width)
    y = np.linspace(0, 2 * np.pi, height)
    xv, yv = np.meshgrid(x, y)

    # Phase shift to break repeat
    x_phase = x_offset * scale * 2 * np.pi / CHUNK_WIDTH

    noise = np.zeros((height, width))
    for oct in range(octaves):
        freq = 2 ** oct
        noise += (1 / freq) * (
            np.sin((xv + x_phase) * freq) * np.cos(yv * freq * 1.3) +
            np.sin(yv * freq * 0.7) * np.cos((xv + x_phase) * freq * 1.7)
        )

    # Add radial pulse for depth
    radius = np.sqrt((xv - np.pi)**2 + (yv - np.pi)**2)
    noise += 0.5 * np.sin(radius * 0.5)

    noise = (noise - noise.min()) / (noise.max() - noise.min())
    return noise_to_rainbow(noise, hue_center, hue_range)

def noise_to_rainbow(noise, hue_center, hue_range):
    """Map normalized noise to vivid HSV rainbow, then RGB"""
    h = (noise * hue_range + hue_center) % 1.0

    # Add vertical hue drift to avoid visual repetition
    y_gradient = np.linspace(0, 1, noise.shape[0])[:, np.newaxis]
    h = (h + y_gradient * 0.05) % 1.0

    s = np.ones_like(h) * 0.9
    v = np.power(noise, 0.3) * 0.8 + 0.2

    c = v * s
    x = c * (1 - np.abs((h * 6) % 2 - 1))
    m = v - c

    rgb = np.zeros((*h.shape, 3))
    conditions = [
        ((0 <= h) & (h < 1/6), (c, x, 0)),
        ((1/6 <= h) & (h < 1/3), (x, c, 0)),
        ((1/3 <= h) & (h < 1/2), (0, c, x)),
        ((1/2 <= h) & (h < 2/3), (0, x, c)),
        ((2/3 <= h) & (h < 5/6), (x, 0, c)),
        ((5/6 <= h) & (h <= 1), (c, 0, x)),
    ]
    for cond, vals in conditions:
        rgb[cond] = np.stack(vals, axis=-1)

    return ((rgb + m[..., np.newaxis]) * 255).astype(np.uint8)

def save_chunk(chunk, x_offset):
    """Save a contrast-enhanced image chunk with optional left-edge blend"""
    img = Image.fromarray(chunk)

    if x_offset > 0:
        blend_width = min(64, CHUNK_WIDTH // 4)
        mask = Image.new('L', (CHUNK_WIDTH, HEIGHT), 255)

        # Left edge gradient (0 → 255)
        for x in range(blend_width):
            alpha = int(255 * x / blend_width)
            for y in range(HEIGHT):
                mask.putpixel((x, y), alpha)

        prev_path = os.path.join(TEMP_DIR, f"chunk_{x_offset - CHUNK_WIDTH:06d}.jpg")
        if os.path.exists(prev_path):
            prev_img = Image.open(prev_path)
            img = Image.composite(img, prev_img, mask)
            prev_img.close()

    img = ImageOps.autocontrast(img)
    img = ImageEnhance.Contrast(img).enhance(CONTRAST_BOOST)

    path = os.path.join(TEMP_DIR, f"chunk_{x_offset:06d}.jpg")
    img.save(path, quality=90, dpi=(DPI, DPI), optimize=True, progressive=True)
    return path

def assemble_final_image():
    final = Image.new('RGB', (WIDTH, HEIGHT))
    chunks = sorted(os.listdir(TEMP_DIR))
    for chunk_file in chunks:
        try:
            x = int(chunk_file.split('_')[1].split('.')[0])
            img = Image.open(os.path.join(TEMP_DIR, chunk_file))
            final.paste(img, (x, 0))
            img.close()
        except Exception as e:
            timed_log(f"⚠️ Error in {chunk_file}: {str(e)}")

    final.save(OUTPUT_FILE, quality=95, dpi=(DPI, DPI), optimize=True, progressive=True)
    return final.size

def generate_camouflage():
    start_time = time.time()
    setup_environment()
    timed_log(f"🚀 Generating {WIDTH:,}x{HEIGHT} seamless rainbow camouflage")

    base_seed = 42
    random.seed(base_seed)

    try:
        for i, x in enumerate(range(0, WIDTH, CHUNK_WIDTH)):
            chunk_w = min(CHUNK_WIDTH, WIDTH - x)
            timed_log(f"🎨 Chunk {x:,}–{x+chunk_w:,} ({(x+chunk_w)/WIDTH*100:.1f}%)")
            random.seed(base_seed + i)  # Per-chunk consistency
            chunk = generate_seamless_noise(HEIGHT, chunk_w, x, base_seed + i)
            save_chunk(chunk, x)
            del chunk

            if x % (CHUNK_WIDTH * 10) == 0:
                time.sleep(0.1)

        timed_log("🧩 Stitching chunks...")
        final_size = assemble_final_image()

        elapsed = timedelta(seconds=int(time.time() - start_time))
        timed_log(f"\n✅ Completed in {elapsed}")
        timed_log(f"📏 Final resolution: {final_size[0]:,}×{final_size[1]} px")
        timed_log(f"📦 File size: {os.path.getsize(OUTPUT_FILE)/1024/1024:.1f} MB")

    except KeyboardInterrupt:
        timed_log("⚠️ Interrupted! Attempting partial stitch...")
        if os.listdir(TEMP_DIR):
            partial_size = assemble_final_image()
            timed_log(f"💾 Partial saved ({partial_size[0]} px wide)")
        raise

if __name__ == "__main__":
    try:
        generate_camouflage()
    except KeyboardInterrupt:
        timed_log("🚫 Cancelled by user")
