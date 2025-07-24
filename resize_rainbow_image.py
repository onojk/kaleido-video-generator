from PIL import Image
import os

# Input from generator
src_path = "/home/ubuntu/kaleido_render_pipeline/current_abstract_video_image.jpg"
# Output resized version for Kdenlive
dst_path = "rainbow_camouflage_resized.jpg"

# Kdenlive uses 4K UHD 16:9 input — we'll use 3840x2160
target_size = (3840, 2160)

if not os.path.exists(src_path):
    raise FileNotFoundError(f"Image not found: {src_path}")

img = Image.open(src_path)
resized = img.resize(target_size, Image.LANCZOS)
resized.save(dst_path)

print(f"[✓] Resized image saved to: {dst_path}")
