# CLAUDE.md — Developer Guide for Claude Code

## Project: Kaleidoscope Video Generator
**Author:** Jonathan Kendall ([@onojk](https://github.com/onojk))  
**Repo:** https://github.com/onojk/kaleido-video-generator

---

## What this project does

A Flask web app that procedurally generates 4K kaleidoscopic videos from
rainbow geometric camo patterns. The pipeline is:

1. **generate_camogen_image.py** — draws random colored polygons → `camo_raw.jpg`
2. **apply_swirl.py** — applies grid-balanced swirl distortions → `camo.jpg`
3. **generate.sh** — drives ImageMagick + FFmpeg in 8 steps:
   - [STEP 1] Generate camo base image (150–400 shapes depending on duration)
   - [STEP 2] Apply swirl distortion (skipped for ≤30 s renders)
   - [STEP 3] Upscale to 1920×1080 (≤30 s) or 3840×2160 (longer)
   - [STEP 4] Build wide scrolling panorama
   - [STEP 5] Render L→R and R→L pan segments in alternating loops
   - [STEP 6] Assemble + trim to final duration
   - [STEP 7] Optional APPLY_KDEN pre-mirror frei0r pass; 2×2 mirror; optional mandala fill → `kaleido_output.mp4`
   - [STEP 8] **frei0r kaleid0sc0pe final pass** — reads `kaleido_output.mp4`, applies `frei0r=kaleid0sc0pe:KALEIDO_SIDES`, overwrites output. Skipped gracefully if plugin is absent; auto-installs via `apt-get` on first run.
4. **src/app.py** — Flask backend that manages render jobs (UUID per job)
5. **templates/index.html** — Browser UI with sliders and live log polling

---

## Directory layout

```
kaleido-video-generator/
├── src/
│   └── app.py               ← Flask app (run this)
├── scripts/
│   ├── generate.sh          ← Main pipeline (bash)
│   ├── generate_camogen_image.py
│   └── apply_swirl.py
├── templates/
│   └── index.html
├── static/
│   └── style.css
├── jobs/                    ← Auto-created; one UUID dir per render job
├── logs/                    ← Gunicorn logs
├── requirements.txt
├── setup.sh                 ← First-time bootstrap
├── start_server.sh          ← Launch Gunicorn
├── diag.sh                  ← Diagnostics
└── CLAUDE.md                ← This file
```

---

## Running locally

```bash
# 1. Bootstrap (creates .venv, installs deps, checks ffmpeg/imagemagick)
bash setup.sh

# 2. Activate venv
source .venv/bin/activate

# 3. Start server
./start_server.sh          # → http://localhost:5000

# Or run Flask dev server directly:
cd src && python3 app.py
```

**System requirements:**
- Python 3.10+
- `ffmpeg` with libx264 (and optionally frei0r plugins)
- `convert` (ImageMagick)

---

## Key environment variables for generate.sh

| Variable       | Default  | Description                                |
|----------------|----------|--------------------------------------------|
| `DURATION`     | 30       | Video length in seconds                    |
| `SCROLL_SPEED` | 0.02     | Pan speed (fraction of width per second)   |
| `BRIGHTNESS`   | 0        | ImageMagick brightness (-127 … 127)        |
| `CONTRAST`     | 0        | ImageMagick contrast (-127 … 127)          |
| `COLORS`       | red,orange,yellow,green | Palette for camo generator  |
| `APPLY_KDEN`   | 0        | 1 = enable frei0r pre-mirror kaleidoscope  |
| `KALEIDO_SIDES`| 12       | Wedge count for frei0r kaleid0sc0pe (steps 7 & 8) |
| `FILL_MANDALA` | 0        | 1 = enable quadrant mandala fill           |
| `SKIP_MIRROR`  | 0        | 1 = skip 2×2 mirror step                  |
| `SEED_QUAD`    | br       | Seed quadrant: tl/tr/bl/br                 |
| `CRF`          | 18       | x264 quality (0=lossless, 51=worst)        |
| `FPS`          | 30       | Frame rate                                 |
| `DRY_RUN`      | 0        | 1 = print commands without running         |
| `FAST_PREVIEW` | 0        | 1 = ultrafast preset, CRF 26, 24fps        |
| `KEEP_TMP`     | 0        | 1 = keep intermediate files in tmp/        |

---

## Common tasks for Claude Code

### Add a new color to the palette
Edit `scripts/generate_camogen_image.py` → `COLOR_MAP` dict, then add it
to `templates/index.html` in the `palette` Jinja list.

### Tune swirl parameters
Edit `scripts/apply_swirl.py` — the `grid_cols`, `grid_rows`,
`swirls_per_cell`, `radius` range, and `strength` range.

### Add a new Flask route
Edit `src/app.py`. The app object is `app`. All job data lives in the
module-level `jobs: dict[str, RenderJob]` dictionary.

### Test the pipeline without the web UI
```bash
mkdir -p /tmp/test_job
cp scripts/{generate.sh,generate_camogen_image.py,apply_swirl.py} /tmp/test_job/
chmod +x /tmp/test_job/generate.sh
DURATION=10 FAST_PREVIEW=1 /tmp/test_job/generate.sh /tmp/test_job
# output: /tmp/test_job/kaleido_output.mp4
```

---

## Known issues / things to watch

- **generate_camogen_image.py** had duplicate `import` blocks and a
  hardcoded `/home/ubuntu/…` path — both fixed in this clean version.
- **app.py** `download()` route had an unreachable `return` statement
  before the `@app.route` decorator — fixed.
- The `jobs/` dir can grow large (each job keeps its MP4). Consider
  adding a cleanup cron or a `/admin/cleanup` route.
- Frei0r kaleidoscope only works if FFmpeg was built with frei0r support.
  Run `diag.sh` to check.
