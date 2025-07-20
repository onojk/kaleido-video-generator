# Kaleido Video Generator

This repository contains scripts and templates for generating abstract high-resolution rainbow camouflage images  
and rendering them into 4K UHD 60fps videos using Kdenlive's headless mode.

## Features

- Procedural rainbow pattern generation  
- Maximum contrast enhancement with GIMP-style logic  
- Grid and seamless pattern creation  
- Automatic video project generation using Kdenlive `.kdenlive` templates  
- Optional integration with external upscalers like Upscayl  

## Folder Overview

- `*.py` — Python scripts for image generation, processing, and video rendering  
- `*.kdenlive` — Project templates for batch video rendering in Kdenlive  
- `LICENSE` — Licensing terms for the project  

## Quickstart

```bash
# Generate an abstract rainbow image
python3 generate_rainbow.py

# Apply maximum contrast enhancement
python3 apply_max_contrast_final.py

# Resize and prep for video
python3 resize_large_image.py

# Render using Kdenlive (headless)
kdenlive_render -mlt /path/to/render_this.kdenlive
```

## Requirements

- Python 3  
- PIL (Pillow)  
- NumPy  
- Kdenlive (CLI tools must be available)  

## Optional Tools

- Upscayl (for image upscaling)  
- GIMP (if using .scm scripts)  

## License

MIT License – see LICENSE for full terms.
