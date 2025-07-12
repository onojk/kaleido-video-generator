#!/usr/bin/env python3
import numpy as np
from PIL import Image, ImageEnhance
import os
import time

OUTPUT_FILE = "/home/onojk123/kaleido_render_pipeline/current_abstract_video_image.jpg"
WIDTH, HEIGHT = 48000, 2160  # UHD height with very wide width

def generate_hard_edge_rainbow():
    np.random.seed(int(time.time()))
    x = np.linspace(0, 20, WIDTH)
    y = np.linspace(0, 5, HEIGHT)
    xv, yv = np.meshgrid(x, y)
    
    r = (np.sin(xv * 3 + yv) + 1) / 2
    g = (np.sin(xv * 3 + yv + 2*np.pi/3) + 1) / 2
    b = (np.sin(xv * 3 + yv + 4*np.pi/3) + 1) / 2

    rgb_array = np.stack([r, g, b], axis=2)
    rgb_array = (rgb_array * 255).astype(np.uint8)

    img = Image.fromarray(rgb_array, 'RGB')

    # Enhance contrast sharply (like 5x GIMP passes)
    for _ in range(5):
        enhancer = ImageEnhance.Contrast(img)
        img = enhancer.enhance(100)  # max contrast

    img.save(OUTPUT_FILE, "JPEG", quality=95)
    print(f"[+] Saved hard-edged camouflage: {OUTPUT_FILE}")

if __name__ == "__main__":
    generate_hard_edge_rainbow()
