# generate_rainbow_image.py
import sys, os
from PIL import Image
import numpy as np

def generate_diagonal_rainbow(width=1920, height=1080):
    gradient = np.zeros((height, width, 3), dtype=np.uint8)
    for y in range(height):
        for x in range(width):
            hue = int((x + y) % 1536 / 6)
            r = max(0, 255 - abs(hue - 255))
            g = max(0, 255 - abs(hue - 510))
            b = max(0, 255 - abs(hue - 765))
            gradient[y, x] = (r, g, b)
    return Image.fromarray(gradient)

if __name__ == "__main__":
    output_path = sys.argv[-1]
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    img = generate_diagonal_rainbow()
    img.save(output_path)
    print(f"✅ Saved rainbow to {output_path}")
