import random
import numpy as np
from PIL import Image
from skimage.transform import swirl
import sys, signal

def handle_interrupt(sig, frame):
    print("\n🌀 Swirl process interrupted")
    sys.exit(1)

signal.signal(signal.SIGINT, handle_interrupt)


# === Input / Output Paths ===
input_path = sys.argv[1]
output_path = sys.argv[2]

# === Load Image ===
img = Image.open(input_path).convert("RGB")
np_img = np.array(img)
height, width = np_img.shape[:2]

# === Grid setup for full balance ===
grid_cols = 6  # balanced spread
grid_rows = 4
swirls_per_cell = 2
num_swirls = grid_cols * grid_rows * swirls_per_cell

cell_w = width // grid_cols
cell_h = height // grid_rows

print(f"🌀 Applying {num_swirls} swirls (balanced left/right)...")

for row in range(grid_rows):
    for col in range(grid_cols):
        for _ in range(swirls_per_cell):
            center_x = random.randint(col * cell_w, (col + 1) * cell_w - 1)
            center_y = random.randint(row * cell_h, (row + 1) * cell_h - 1)

            # Balanced strength and size
            radius = random.randint(int(0.2 * min(width, height)), int(0.35 * min(width, height)))
            strength = random.uniform(15, 30)

            print(f"🌪 Swirl at ({center_x},{center_y}) with strength={strength:.1f}, radius={radius}")
            np_img = swirl(
                np_img,
                center=(center_y, center_x),
                strength=strength,
                radius=radius,
                rotation=0,
                mode='reflect'
            )

# === Save Output ===
out_img = Image.fromarray((np.clip(np_img, 0, 1) * 255).astype(np.uint8))
out_img.save(output_path)
print(f"✅ Swirled image saved to: {output_path}")
