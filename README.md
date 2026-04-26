# 🌈 Kaleidoscope Video Generator

A Flask-powered pipeline that procedurally generates kaleidoscopic 4K UHD videos
from vibrant, swirled rainbow camouflage patterns.

**Author:** Jonathan Kendall — [@onojk](https://github.com/onojk)

---

## What it does

- 🎨 Generates abstract rainbow camo using procedural polygon geometry
- 🌪️ Applies randomized grid-balanced swirl distortions
- 🎞️ Scrolls a wide panorama left↔right for organic camera motion
- 🔮 Optionally applies a Frei0r radial kaleidoscope effect
- 🔀 Mirrors quadrants into a full 2×2 mandala frame
- 💾 Outputs clean 4K H.264 MP4
- 🌐 Browser-based UI with live log streaming and download

---

## Quick start

```bash
git clone https://github.com/onojk/kaleido-video-generator
cd kaleido-video-generator

# Install Python deps + check system tools
bash setup.sh

# Activate venv & launch
source .venv/bin/activate
./start_server.sh
```

Then open **http://localhost:5000** in your browser.

**System requirements:** Python 3.10+, `ffmpeg` (libx264), `convert` (ImageMagick)

---

## Project structure

```
kaleido-video-generator/
├── src/app.py                    # Flask backend + job manager
├── scripts/
│   ├── generate.sh               # Unified FFmpeg/ImageMagick pipeline
│   ├── generate_camogen_image.py # Rainbow camo generator
│   └── apply_swirl.py            # Swirl distortion processor
├── templates/index.html          # Web UI
├── static/style.css
├── jobs/                         # Per-job UUID directories (auto-created)
├── setup.sh                      # First-run bootstrap
├── start_server.sh               # Launch Gunicorn
├── diag.sh                       # Diagnostic tool
└── CLAUDE.md                     # Developer notes (for Claude Code)
```

---

## Pipeline overview

1. **Camo generation** — `generate_camogen_image.py`
   draws random filled polygons in chosen colors at 1920×1080.

2. **Swirl distortion** — `apply_swirl.py`
   applies 48 balanced swirls across a 6×4 grid using `scikit-image`.

3. **generate.sh** pipeline:
   - ImageMagick: brightness/contrast + upscale to 3840×2160
   - Build a wide panorama and render alternating L→R / R→L segments
   - Optional: Frei0r `kaleid0sc0pe` radial effect
   - Optional: 2×2 quadrant mirror
   - Optional: single-quadrant mandala tile fill

4. **Flask app** — each render gets a UUID job directory;
   progress and logs are polled by the browser every 1.5 s.

---

## CLI usage

Test the pipeline without the web UI:

```bash
mkdir -p /tmp/test_job
cp scripts/{generate.sh,generate_camogen_image.py,apply_swirl.py} /tmp/test_job/
chmod +x /tmp/test_job/generate.sh

DURATION=15 FAST_PREVIEW=1 COLORS="blue,indigo,violet,green" \
  /tmp/test_job/generate.sh /tmp/test_job

# Output: /tmp/test_job/kaleido_output.mp4
```

Key env vars: `DURATION`, `SCROLL_SPEED`, `BRIGHTNESS`, `CONTRAST`, `COLORS`,
`APPLY_KDEN`, `FILL_MANDALA`, `SKIP_MIRROR`, `CRF`, `FPS`, `FAST_PREVIEW`.
See `CLAUDE.md` for the full table.

---

## License

MIT — see LICENSE
