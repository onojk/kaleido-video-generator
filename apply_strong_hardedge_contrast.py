#!/usr/bin/env python3
import numpy as np
from PIL import Image
import time
import sys

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")
    sys.stdout.flush()

def hard_edge_contrast(img_array, passes=5, levels=8):
    """Posterizes image to fewer levels repeatedly to sharpen contrast edges."""
    arr = img_array / 255.0
    for _ in range(passes):
        arr = np.round(arr * (levels - 1)) / (levels - 1)
    return (arr * 255).clip(0, 255).astype(np.uint8)

def main():
    input_path = "rainbow_camouflage_seamless.jpg"
    output_path = "rainbow_camouflage_contrast_hardedges.jpg"

    log(f"📂 Opening {input_path}")
    img = Image.open(input_path).convert("RGB")
    arr = np.array(img)

    log("🎚️ Applying strong hard-edged contrast (multi-pass posterization)...")
    processed = hard_edge_contrast(arr, passes=5, levels=8)

    log(f"💾 Saving to {output_path}")
    Image.fromarray(processed).save(output_path, quality=95)
    log("✅ Done!")

if __name__ == "__main__":
    main()
