#!/usr/bin/env python3
from PIL import Image

img = Image.open("rainbow_camouflage_contrast.jpg")
img = img.resize((3840, 2160), Image.LANCZOS)
img.save("rainbow_camouflage_resized.jpg")
