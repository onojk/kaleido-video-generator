#!/usr/bin/env python3
from PIL import Image, ImageOps

img = Image.open("rainbow_camouflage.jpg").convert("RGB")
img = ImageOps.autocontrast(img)
img.save("rainbow_camouflage_contrast.jpg")
