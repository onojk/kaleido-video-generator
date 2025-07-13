import numpy as np
from PIL import Image
import time
from datetime import timedelta
import os
import gc

def safe_fast_max_contrast_chunk(rgb_chunk):
    """Max contrast for a chunk with divide-by-zero safety"""
    r, g, b = rgb_chunk[..., 0], rgb_chunk[..., 1], rgb_chunk[..., 2]
    max_val = np.maximum.reduce([r, g, b])
    min_val = np.minimum.reduce([r, g, b])
    delta = max_val - min_val
    
    # Avoid division by zero
    delta = np.where(delta == 0, 1, delta)
    
    # Calculate Hue
    h = np.zeros_like(max_val)
    mask = delta != 0
    max_r = (max_val == r) & mask
    max_g = (max_val == g) & mask
    max_b = (max_val == b) & mask
    
    h = np.where(max_r, (60 * ((g - b)/delta)) % 360, h)  # Fixed parenthesis
    h = np.where(max_g, (60 * ((b - r)/delta) + 120) % 360, h)
    h = np.where(max_b, (60 * ((r - g)/delta) + 240) % 360, h)
    h = (h * 255 / 360).astype(np.uint8)
    
    s = np.where(delta == 0, 0, 255).astype(np.uint8)
    v = max_val.astype(np.uint8)
    
    hsv = np.dstack((h, s, v))
    return Image.fromarray(hsv, 'HSV').convert('RGB')

def generate_smooth_huge_noise_image():
    width, height = 48000, 27000
    dpi = 72
    chunk_size = 1024
    output_path = "48k_max_contrast_noise_smooth.jpg"
    
    print(f"⚡ Generating {width}x{height}px image (Chunk Size: {chunk_size}px)")
    start_time = time.time()
    
    final_img = Image.new('RGB', (width, height))
    
    for i in range(0, width, chunk_size):
        chunk_width = min(chunk_size, width - i)
        print(f"🔧 Chunk {i//chunk_size + 1}/{(width//chunk_size)+1}: {i}-{i+chunk_width}px", end='\r')
        
        noise = np.random.randint(0, 256, (height, chunk_width, 3), dtype=np.uint8)
        contrast_chunk = safe_fast_max_contrast_chunk(noise)
        final_img.paste(contrast_chunk, (i, 0))
        
        del noise, contrast_chunk
        gc.collect()
        time.sleep(0.1)
    
    print("\n✅ Contrast applied smoothly!")
    
    final_img.save(
        output_path,
        'JPEG',
        quality=90,
        progressive=True,
        dpi=(dpi, dpi)
    )
    
    total_time = time.time() - start_time
    print(f"""
    🎉 Completed in {timedelta(seconds=int(total_time))}
    📐 Dimensions: {width}x{height}px
    📊 File size: {os.path.getsize(output_path)/1024/1024:.1f}MB
    """)

if __name__ == "__main__":
    generate_smooth_huge_noise_image()
