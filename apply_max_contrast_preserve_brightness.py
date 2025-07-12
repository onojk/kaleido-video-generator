#!/usr/bin/env python3
from PIL import Image, ImageEnhance
import time
import os

# === Config ===
INPUT_PATH = "rainbow_camouflage_seamless.jpg"
OUTPUT_PATH = "rainbow_camouflage_contrast_boosted.jpg"

def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}")

def apply_max_contrast_pillow_style(image):
    # Max out contrast like GIMP +127 (Pillow scale: factor ~2.0–2.5)
    enhancer = ImageEnhance.Contrast(image)
    return enhancer.enhance(2.5)  # GIMP visual equivalent

def main():
    log(f"📂 Opening {INPUT_PATH}")
    img = Image.open(INPUT_PATH).convert("RGB")

    log("🎚️ Applying max contrast (like GIMP +127)...")
    contrasted = apply_max_contrast_pillow_style(img)

    log(f"💾 Saving to {OUTPUT_PATH}")
    contrasted.save(OUTPUT_PATH, quality=95)

    log("✅ Done!")

if __name__ == "__main__":
    main()
