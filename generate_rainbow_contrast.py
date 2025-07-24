import numpy as np
from PIL import Image, ImageEnhance
import argparse
import os

def generate_rainbow_image(width, height):
    """Generate a diagonal rainbow gradient image."""
    x = np.linspace(0, 1, width)
    y = np.linspace(0, 1, height)
    xx, yy = np.meshgrid(x, y)
    gradient = (xx + yy) / 2

    r = np.uint8(255 * np.clip(np.sin(2 * np.pi * gradient), 0, 1))
    g = np.uint8(255 * np.clip(np.sin(2 * np.pi * gradient + 2), 0, 1))
    b = np.uint8(255 * np.clip(np.sin(2 * np.pi * gradient + 4), 0, 1))

    image = np.stack([r, g, b], axis=2)
    return Image.fromarray(image, mode='RGB')

def apply_max_contrast(img):
    """Apply max contrast using PIL."""
    enhancer = ImageEnhance.Contrast(img)
    return enhancer.enhance(3.0)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', required=True)
    parser.add_argument('--width', type=int, default=1920)
    parser.add_argument('--height', type=int, default=1080)
    args = parser.parse_args()

    print(f"[🎨] Generating rainbow image: {args.width}x{args.height}")
    img = generate_rainbow_image(args.width, args.height)
    img = apply_max_contrast(img)
    img.save(args.output)
    print(f"[✅] Saved: {args.output}")
