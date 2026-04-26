# 🌈 Kaleidoscope Video Generator

A Flask-powered pipeline that procedurally generates kaleidoscopic 4K UHD videos
from vibrant, swirled rainbow camouflage patterns.

**Author:** Jonathan Kendall — [@onojk](https://github.com/onojk)

---

## What it does

- 🎨 Generates rich psychedelic camo using 8 procedural shape types across 3 depth layers
- 🌪️ Applies randomized grid-balanced swirl distortions
- 🎞️ Scrolls a wide panorama left↔right for organic camera motion
- ⚡ Renders segments in parallel across CPU cores for 4–6× speedup on long videos
- 🔮 Optionally applies a Frei0r radial kaleidoscope effect
- 🔀 Mirrors quadrants into a full 2×2 mandala frame
- 🎬 Six quality presets from Preview 480p to 4K HQ
- 💾 Outputs clean H.264 MP4 at your chosen resolution
- 🌐 Browser UI with live per-segment progress, log streaming, and download

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

Optional but recommended: `gnu parallel` (auto-installed if absent), `frei0r-plugins`

---

## Project structure

```
kaleido-video-generator/
├── src/app.py                    # Flask backend + job manager
├── scripts/
│   ├── generate.sh               # Unified FFmpeg/ImageMagick pipeline
│   ├── generate_camogen_image.py # Psychedelic camo generator (8 shape types)
│   ├── apply_swirl.py            # Swirl distortion processor
│   └── plan_segments.py          # Parallel segment geometry planner
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

### Step 1 — Camo generation (`generate_camogen_image.py`)

Draws 600–1000 shapes in three depth passes (background, midground, foreground)
using 8 procedural shape types:

| Shape | Description |
|-------|-------------|
| Polygon | 3–11 sided regular polygons |
| Star | 5–12 point stars with inner/outer radii |
| Blob | 20–40 vertex perturbed organic shapes |
| Ellipse | Rotated ellipses approximated as 32-pt polygons |
| Lightning | 4–10 segment jagged lines |
| Spiral | Dot-trail spirals |
| Crosshatch | Rotated overlapping rectangles |
| Arc | Partial ellipse arcs |

Each base color gets 6 palette variants (base, two darks, two tints, hue-shifted).
18% of solid shapes get a lighter offset glow echo for depth.

### Step 2 — Swirl distortion (`apply_swirl.py`)

Applies randomized swirls across a grid using `scikit-image`. Skipped automatically
for short (≤30 s) renders to keep preview generation fast.

### Steps 3–6 — `generate.sh` pipeline

| Step | Action |
|------|--------|
| 1 | Generate camo base image |
| 2 | Apply swirl distortion (or skip for fast mode) |
| 3 | ImageMagick: brightness/contrast + upscale to output resolution |
| 4 | Build wide scrolling panorama |
| 5 | **Parallel segment rendering** (see below) |
| 6 | FFmpeg concat segments → `pan_final.mp4` (stream copy, no re-encode) |
| 7 | Optional Frei0r pre-mirror effect, 2×2 quadrant mirror, mandala fill |
| 8 | Frei0r `kaleid0sc0pe` final pass (auto-installs plugin if absent) |

### Parallel segment rendering

Instead of one long FFmpeg pass, the full duration is split into fixed-length chunks
(default 30 s each) that are rendered independently and then concatenated:

- Each chunk gets its own exact scroll position computed by `plan_segments.py`
  so clips join frame-perfectly with no visible seam
- Chunks are dispatched via **GNU parallel** (`-j N/2` workers) or a bash
  job-control pool if parallel is not available
- Completed segments are cached under `tmp/segs/<hash>/` keyed to the base
  image + encoding params — cancelling and restarting reuses finished segments
- A 337 s 4K render goes from ~40 min sequential to ~8–10 min on a multi-core machine

### Flask app (`src/app.py`)

- Each render gets a UUID job directory under `jobs/`
- Progress bar interpolates smoothly from 20 % → 60 % as segments complete
  (parsed from `[SEG N/M]` log markers) then jumps to 100 % on finalisation
- Download button appears only after confirmed completion; **Start New Render**
  requires an explicit click so accidental re-triggers are impossible

---

## Quality presets

| Preset | Resolution | CRF | Speed | FPS |
|--------|-----------|-----|-------|-----|
| Preview 480p | 854×480 | 32 | ultrafast | 24 |
| Preview 720p | 1280×720 | 28 | ultrafast | 24 |
| **Standard HD** *(default)* | 1920×1080 | 18 | medium | 30 |
| Full HD | 1920×1080 | 12 | slow | 30 |
| 4K UHD | 3840×2160 | 12 | slow | 30 |
| 4K HQ | 3840×2160 | 8 | slow | 30 |

---

## CLI usage

Test the pipeline without the web UI:

```bash
mkdir -p /tmp/test_job
cp scripts/{generate.sh,generate_camogen_image.py,apply_swirl.py,plan_segments.py} /tmp/test_job/
chmod +x /tmp/test_job/generate.sh

DURATION=15 FAST_PREVIEW=1 COLORS="blue,indigo,violet,green" \
  /tmp/test_job/generate.sh /tmp/test_job

# Output: /tmp/test_job/kaleido_output.mp4
```

Key env vars:

| Variable | Default | Description |
|----------|---------|-------------|
| `DURATION` | 30 | Video length in seconds |
| `SEGMENT_LEN` | 30 | Max seconds per parallel render chunk |
| `WORKERS` | nproc/2 | Parallel worker count (capped at 8) |
| `SCROLL_SPEED` | 0.02 | Pan speed (fraction of width per second) |
| `BRIGHTNESS` | 0 | ImageMagick brightness (−127…127) |
| `CONTRAST` | 0 | ImageMagick contrast (−127…127) |
| `COLORS` | red,orange,yellow,green | Palette colors |
| `WIDTH` / `HEIGHT` | 1920 / 1080 | Output resolution |
| `CRF` | 18 | x264 quality (0 = lossless, 51 = worst) |
| `PRESET` | medium | FFmpeg encoding preset |
| `FPS` | 30 | Frame rate |
| `KALEIDO_SIDES` | 12 | Frei0r kaleidoscope wedge count |
| `APPLY_KDEN` | 0 | 1 = Frei0r pre-mirror pass |
| `FILL_MANDALA` | 0 | 1 = quadrant mandala fill |
| `SKIP_MIRROR` | 0 | 1 = skip 2×2 mirror |
| `FAST_PREVIEW` | 0 | 1 = ultrafast preset, CRF 26, 24 fps |
| `DRY_RUN` | 0 | 1 = print commands without executing |
| `KEEP_TMP` | 0 | 1 = keep intermediate files |

See `CLAUDE.md` for the full developer reference.

---

## License

MIT — see LICENSE
