#!/usr/bin/env python3
from PIL import Image
import numpy as np
import time

INPUT = "rainbow_camouflage_seamless.jpg"
OUTPUT = "rainbow_camouflage_contrast_boosted.jpg"
PASSES = 5       # Number of contrast passes
STEPS = 6        # Number of discrete levels per channel (like posterize)

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def hard_edge_contrast(arr, steps=6):
    """Normalize and quantize to `steps` discrete levels per channel."""
    for c in range(3):  # R, G, B
        ch = arr[..., c]
        ch_min = ch.min()
        ch_max = ch.max()
        if ch_max > ch_min:
            # Normalize 0–1
            ch_norm = (ch - ch_min) / (ch_max - ch_min)
            # Quantize to N bins
            bins = np.linspace(0, 1, steps + 1)
            ch_quantized = np.digitize(ch_norm, bins) - 1
            ch = (ch_quantized / steps) * 255
            arr[..., c] = ch
    return arr

def main():
    log(f"📂 Opening {INPUT}")
    img = Image.open(INPUT).convert("RGB")
    arr = np.array(img).astype(np.float32)

    for i in range(PASSES):
        log(f"🌀 Pass {i+1}/{PASSES}: Hard-edge contrast")
        arr = hard_edge_contrast(arr, steps=STEPS)

    arr = np.clip(arr, 0, 255).astype(np.uint8)
    out_img = Image.fromarray(arr)
    log(f"💾 Saving to {OUTPUT}")
    out_img.save(OUTPUT, quality=95)
    log("✅ Saved with psychedelic contrast!")

if __name__ == "__main__":
    main()
