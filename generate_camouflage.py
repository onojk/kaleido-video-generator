#!/usr/bin/env python3
import numpy as np
from PIL import Image
import os
from tqdm import tqdm

# 4K-compatible dimensions
WIDTH = 48000  # Ultra-wide panorama
HEIGHT = 2160   # 4K UHD height
TILE_SIZE = 2000  # Memory-friendly chunks
OCTAVES = 6
OUTPUT_DIR = "assets"

def generate_camouflage():
    print(f"Generating {WIDTH}x{HEIGHT} camouflage (4K height)...")
    os.makedirs(OUTPUT_DIR, exist_ok=True)
    
    # Initialize empty image
    final_img = Image.new('RGB', (WIDTH, HEIGHT))
    
    # Process in vertical strips
    for x_start in tqdm(range(0, WIDTH, TILE_SIZE), desc="Generating"):
        x_end = min(x_start + TILE_SIZE, WIDTH)
        strip_width = x_end - x_start
        
        # Generate noise for current strip
        x, y = np.meshgrid(
            np.linspace(0, 1, strip_width),
            np.linspace(0, 1, HEIGHT))
        noise = np.zeros((HEIGHT, strip_width, 3))
        
        # Multi-octave noise (FIXED PARENTHESES)
        for octave in range(OCTAVES):
            freq = 2 ** octave
            amp = 0.5 ** octave
            for c in range(3):
                phase = c * 2 * np.pi / 3
                noise[:,:,c] += amp * np.sin(2 * np.pi * freq * 
                          (x * np.cos(phase) + y * np.sin(phase) + np.random.random()))
        
        # Normalize and paste
        noise = (255 * (noise - noise.min()) / (noise.max() - noise.min())).astype(np.uint8)
        strip = Image.fromarray(noise)
        final_img.paste(strip, (x_start, 0))
    
    # Save final image
    output_path = os.path.join(OUTPUT_DIR, "rainbow_camouflage.tif")
    final_img.save(output_path, compression='tiff_lzw')
    print(f"\nSaved to {output_path}")

if __name__ == "__main__":
    generate_camouflage()
