#!/usr/bin/env python3
import numpy as np
import os
from PIL import Image, ImageOps
import sys

# === Image Size ===
WIDTH, HEIGHT = 3840, 2160  # 4K UHD

# === Prime Divided Noise ===
def generate_prime_noise(width, height):
    primes = [2, 3, 5, 7, 11, 13, 17]
    x = np.linspace(0, 1, width)
    y = np.linspace(0, 1, height)
    xv, yv = np.meshgrid(x, y)

    r = sum(np.sin(xv * p * np.pi) / p for p in primes)
    g = sum(np.cos(yv * p * np.pi) / p for p in primes[::-1])
    b = sum(np.sin((xv + yv) * p * np.pi) / p for p in primes[::2])

    rgb = np.stack([r, g, b], axis=-1)
    rgb = (rgb - rgb.min()) / (rgb.max() - rgb.min())  # normalize
    return (rgb * 255).astype(np.uint8)

# === Zoom and Contrast ===
def zoom_image(image, factor=2.5):
    w, h = image.size
    new_w, new_h = int(w / factor), int(h / factor)
    left = (w - new_w) // 2
    top = (h - new_h) // 2
    cropped = image.crop((left, top, left + new_w, top + new_h))
    return cropped.resize((w, h), Image.BICUBIC)

def apply_max_contrast(image):
    return ImageOps.autocontrast(image, cutoff=0)

# === Main ===
def main(job_id="test_job"):
    print(f"[*] Starting generator script for job_id: {job_id}")
    output_path = f"jobs/{job_id}/current_abstract_video_image.jpg"

    print("[*] Generating prime-divided noise...")
    arr = generate_prime_noise(WIDTH, HEIGHT)
    img = Image.fromarray(arr)
    img = zoom_image(img, factor=np.random.uniform(2.0, 4.0))
    img = apply_max_contrast(img)

    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img.save(output_path, quality=95)
    print(f"[✓] Saved: {output_path}")

if __name__ == "__main__":
    job_id = sys.argv[1] if len(sys.argv) > 1 else "test_job"
    main(job_id)
