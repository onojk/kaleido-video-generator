import os
import subprocess
from PIL import Image

# === Paths ===
INPUT_PATH = "media/distorted_rainbow_grid_small.png"
OUTPUT_DIR = "media"
UPSCALED_PNG_PATH = os.path.join(OUTPUT_DIR, "distorted_rainbow_grid_upscaled.png")
FINAL_JPG_PATH = os.path.join(OUTPUT_DIR, "final_rainbow_grid.jpg")

# === Force Software Rendering Environment ===
SOFT_ENV = os.environ.copy()
SOFT_ENV["ELECTRON_ENABLE_LOGGING"] = "true"
SOFT_ENV["ELECTRON_NO_ATTACH_CONSOLE"] = "1"
SOFT_ENV["ELECTRON_DISABLE_SANDBOX"] = "1"
SOFT_ENV["LIBGL_ALWAYS_SOFTWARE"] = "1"
SOFT_ENV["QT_QUICK_BACKEND"] = "software"
SOFT_ENV["QT_OPENGL"] = "software"

# === Upscale Function ===
def run_upscayl(input_path):
    print(f"Upscaling image using Upscayl: {input_path}")
    command = [
        "./squashfs-root/upscayl",
        "--input", input_path,
        "--output", OUTPUT_DIR,
        "--scale", "4x",
        "--mode", "Real-ESRGAN",
        "--type", "png"
    ]
    try:
        subprocess.run(command, env=SOFT_ENV, check=True)
    except subprocess.CalledProcessError as e:
        print("Upscayl failed:", e)
        exit(1)

# === Convert PNG to JPG ===
def convert_to_jpg(png_path, jpg_path, quality=90):
    print(f"Converting {png_path} to JPG ({quality}%)")
    with Image.open(png_path) as img:
        rgb = img.convert("RGB")
        rgb.save(jpg_path, "JPEG", quality=quality)
    print(f"Saved final JPG: {jpg_path}")

# === Main ===
def main():
    if not os.path.exists(INPUT_PATH):
        print(f"Input not found: {INPUT_PATH}")
        return
    run_upscayl(INPUT_PATH)
    convert_to_jpg(UPSCALED_PNG_PATH, FINAL_JPG_PATH)

if __name__ == "__main__":
    main()
