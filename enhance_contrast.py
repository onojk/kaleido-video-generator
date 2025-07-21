#!/usr/bin/env python3
from PIL import Image, ImageEnhance
import numpy as np
import os

input_path = "assets/rainbow_camouflage.tif"
output_path = "assets/rainbow_camouflage_contrast.jpg"

# Load image
img = Image.open(input_path)

# Advanced contrast stretching using percentiles
arr = np.array(img)
p2, p98 = np.percentile(arr, (2, 98))
arr = np.clip((arr - p2) * (255.0 / (p98 - p2)), 0, 255).astype(np.uint8)

# Save result
Image.fromarray(arr).save(output_path, quality=95)
print(f"Contrast enhanced image saved to {output_path}")
