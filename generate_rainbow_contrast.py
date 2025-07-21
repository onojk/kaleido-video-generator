#!/usr/bin/env python3
from PIL import Image, ImageDraw
import colorsys
import sys

def generate_rainbow(width, height):
    """Generate rainbow with guaranteed RGB output"""
    img = Image.new('RGB', (width, height))
    draw = ImageDraw.Draw(img)
    
    for x in range(width):
        hue = x / width  # 0.0 (red) to 1.0 (red)
        r, g, b = [int(255 * c) for c in colorsys.hsv_to_rgb(hue, 1.0, 1.0)]
        draw.line([(x, 0), (x, height)], fill=(r, g, b))
    
    # Explicit RGB conversion and verification
    if img.mode != 'RGB':
        img = img.convert('RGB')
    return img

if __name__ == "__main__":
    print("[!] Generating guaranteed-color rainbow...")
    try:
        img = generate_rainbow(3840, 2160)
        img.save("rainbow_gradient_heavy_contrast.jpg", 
               quality=100,
               subsampling=0)
        print("[✓] Saved verified RGB image")
    except Exception as e:
        print(f"[X] Error: {e}", file=sys.stderr)
        sys.exit(1)
