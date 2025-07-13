#!/usr/bin/env python3
from PIL import Image
import numpy as np

width, height = 3840, 2160  # 4K UHD
x = np.linspace(0, 4 * np.pi, width)
y = np.linspace(0, 4 * np.pi, height)
X, Y = np.meshgrid(x, y)
R = (np.sin(X + Y) + 1) * 127.5
G = (np.sin(X - Y) + 1) * 127.5
B = (np.sin(X * 0.5 + Y * 1.5) + 1) * 127.5
img = np.stack([R, G, B], axis=-1).astype(np.uint8)
Image.fromarray(img).save("rainbow_camouflage.jpg")
