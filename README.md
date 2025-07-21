# Kaleido Video Generator

This repository contains scripts and templates for generating abstract high-resolution rainbow camouflage images  
and rendering them into 4K UHD 60fps videos using Kdenlive's headless mode.

## Features

- Procedural rainbow pattern generation  
- Maximum contrast enhancement with GIMP-style logic  
- Grid and seamless pattern creation  
- Automatic video project generation using Kdenlive `.kdenlive` templates  
- Precise video duration control with automated retry rendering script  
- Robust handling of missing plugins and audio files in project XML  
- Optional integration with external upscayl  

## Folder Overview

- `*.py` — Python scripts for image generation, processing, and video rendering  
- `*.kdenlive` — Project templates for batch video rendering in Kdenlive  
- `*.sh` — Shell scripts for automated patching and rendering (e.g., `auto_render_retry.sh`)  
- `LICENSE` — Licensing terms for the project  

## Quickstart

```bash
# Generate an abstract rainbow image
python3 generate_rainbow.py

# Apply maximum contrast enhancement
python3 apply_max_contrast_final.py

# Resize and prep for video
python3 resize_large_image.py

# Use the automated render retry script for precise length video rendering
chmod +x auto_render_retry.sh
./auto_render_retry.sh

# Or manually render using Kdenlive's melt tool (ensure flatpak and Kdenlive installed)
flatpak run org.kde.kdenlive//stable melt patched_render.kdenlive -consumer avformat:final_output.mp4 vcodec=libx264 acodec=aac -end 600
```

## Rendering Automation (`auto_render_retry.sh`)

* Automates patching the `.kdenlive` project XML to set exact video duration in frames.
* Runs rendering via Flatpak Kdenlive's `melt` command with timeout controls.
* Retries render up to 3 times if output duration verification via `ffprobe` fails.
* Filters common benign warnings from render logs for clearer diagnostics.

## Requirements

* Python 3
* PIL (Pillow)
* NumPy
* Flatpak (for Kdenlive app runtime)
* Kdenlive Flatpak package installed (`org.kde.kdenlive`)
* `ffprobe` (from FFmpeg)
* `xmlstarlet` (for XML patching)

## Optional Tools

* Upscayl (for image upscaling)
* GIMP (if using `.scm` scripts)

## Troubleshooting Notes

* Ensure Flatpak's data directories are included in `XDG_DATA_DIRS` to avoid missing plugin errors.
* Missing audio files referenced in the `.kdenlive` template may trigger warnings; they can be safely ignored or the project XML can be patched to remove audio chains.
* The rendering process may emit Qt or QThreadStorage warnings; these are common and generally do not affect output.
* Use the `auto_render_retry.sh` script to reliably produce exactly timed output videos without manual intervention.

## License

MIT License – see LICENSE for full terms.
