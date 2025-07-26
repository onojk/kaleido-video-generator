# generate_rainbow_image.py
import sys, os
from PIL import Image, ImageEnhance
import numpy as np

def generate_diagonal_rainbow(width=1920, height=1080):
    gradient = np.zeros((height, width, 3), dtype=np.uint8)

    for y in range(height):
        for x in range(width):
            hue = int((x + y + 30 * np.sin(y / 40.0) + 30 * np.cos(x / 25.0)) % 1536 / 6)
            r = max(0, 255 - abs(hue - 255))
            g = max(0, 255 - abs(hue - 510))
            b = max(0, 255 - abs(hue - 765))
            gradient[y, x] = (r, g, b)

    # Add blocky noise mask to shuffle areas
    noise = np.random.randint(-50, 50, (height, width, 1), dtype=np.int16)
    gradient = np.clip(gradient.astype(np.int16) + noise, 0, 255).astype(np.uint8)

    return Image.fromarray(gradient)

def apply_hard_contrast(img):
    # Stretch contrast then threshold edges
    enhancer = ImageEnhance.Contrast(img)
    img = enhancer.enhance(2.5)
    img = img.convert("RGB")
    arr = np.array(img)
    arr = (arr > 128) * 255
    return Image.fromarray(arr.astype(np.uint8))

if __name__ == "__main__":
    output_path = sys.argv[-1]
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    img = generate_diagonal_rainbow(3840, 2160)
    img = apply_hard_contrast(img)

    img.save(output_path, quality=95)
    print(f"✅ Saved bold rainbow camouflage to {output_path}")
