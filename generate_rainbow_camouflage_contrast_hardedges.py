import numpy as np
from PIL import Image, ImageOps
import os
import time
import random

WIDTH = 3840
HEIGHT = 2160
OUTPUT_PATH = f"jobs/{os.environ.get('JOB_ID', f'testjob_{int(time.time())}')}/current_abstract_video_image.jpg"

# A pool of prime numbers to choose from
PRIME_POOL = [
     2,  3,  5,  7, 11, 13, 17, 19, 23, 29,
    31, 37, 41, 43, 47, 53, 59, 61, 67, 71,
    73, 79, 83, 89, 97, 101, 103, 107, 109, 113
]

def choose_unique_primes(count=6):
    return random.sample(PRIME_POOL, count)

def generate_prime_noise(width, height, zoom=0.005):
    p1, p2, p3, p4, p5, p6 = choose_unique_primes()

    x = np.linspace(0, width * zoom, width)
    y = np.linspace(0, height * zoom, height)
    X, Y = np.meshgrid(x, y)

    r = np.sin(X * np.pi / p1) + np.cos(Y / p2)
    g = np.sin(X / p3) + np.cos(Y * np.pi / p4)
    b = np.sin(X / p5) + np.cos(Y / p6)

    rgb = np.stack([
        ((r + 2) / 4.0 * 255).astype(np.uint8),
        ((g + 2) / 4.0 * 255).astype(np.uint8),
        ((b + 2) / 4.0 * 255).astype(np.uint8),
    ], axis=2)

    return Image.fromarray(rgb, mode='RGB')

def apply_max_contrast(image):
    return ImageOps.autocontrast(image, cutoff=0)

def main():
    print("[*] Generating prime-based fuzzy rainbow noise with unique primes...")
    img = generate_prime_noise(WIDTH, HEIGHT)
    img = apply_max_contrast(img)
    os.makedirs(os.path.dirname(OUTPUT_PATH), exist_ok=True)
    img.save(OUTPUT_PATH)
    print(f"[✓] Saved: {OUTPUT_PATH}")

if __name__ == "__main__":
    print("[*] Starting generator script...")
    main()
