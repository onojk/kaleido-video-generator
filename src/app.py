"""
Kaleidoscope Video Generator — Flask backend
Author: Jonathan Kendall (@onojk)
"""

import os
import sys
import uuid
import subprocess
import threading
import shutil
import time

import re

from flask import Flask, request, jsonify, send_file, render_template

try:
    import psutil
    HAS_PSUTIL = True
except ImportError:
    HAS_PSUTIL = False

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SCRIPTS_DIR  = os.path.join(PROJECT_ROOT, "scripts")
JOBS_DIR     = os.path.join(PROJECT_ROOT, "jobs")
os.makedirs(JOBS_DIR, exist_ok=True)

# ---------------------------------------------------------------------------
# Flask app
# ---------------------------------------------------------------------------
app = Flask(
    __name__,
    template_folder=os.path.join(PROJECT_ROOT, "templates"),
    static_folder=os.path.join(PROJECT_ROOT, "static"),
)

jobs: dict[str, "RenderJob"] = {}


# ---------------------------------------------------------------------------
# Job class
# ---------------------------------------------------------------------------
class RenderJob:
    STAGES = [
        ("Initializing",            0),
        ("Generating camo pattern", 20),
        ("Applying swirl effects",  40),
        ("Building panorama",       60),
        ("Rendering final video",   80),
        ("Finalizing",             100),
    ]

    def __init__(self, job_id: str, mirror_q1: bool = False):
        self.job_id      = job_id
        self.working_dir = os.path.join(JOBS_DIR, job_id)
        self.status      = "queued"
        self.progress    = 0
        self.output_file: str | None = None
        self.error:       str | None = None
        self.log_path    = os.path.join(self.working_dir, "job.log")
        self.mirror_q1   = mirror_q1
        self.proc:        subprocess.Popen | None = None
        self._cancelled  = False

    # ------------------------------------------------------------------
    def update_stage(self, index: int) -> None:
        if 0 <= index < len(self.STAGES):
            self.status, self.progress = self.STAGES[index]
            self._log(f"PROGRESS: {self.status} ({self.progress}%)")

    def cancel(self) -> None:
        self._cancelled = True
        self.status     = "cancelled"
        if self.proc and self.proc.poll() is None:
            if HAS_PSUTIL:
                try:
                    parent = psutil.Process(self.proc.pid)
                    for child in parent.children(recursive=True):
                        child.kill()
                    parent.kill()
                except psutil.NoSuchProcess:
                    pass
            else:
                self.proc.kill()
        self._log("Job cancelled by user.")

    def _log(self, message: str) -> None:
        ts = time.strftime("%Y-%m-%d %H:%M:%S")
        with open(self.log_path, "a") as fh:
            fh.write(f"[{ts}] {message}\n")

    # ------------------------------------------------------------------
    def run(
        self,
        duration:   int   = 10,
        brightness: int   = 0,
        contrast:   int   = 0,
        speed:      float = 10.0,
        colors:     list  | None = None,
        apply_kden: bool  = False,
        fill_mandala: bool = False,
        skip_mirror: bool  = False,
        seed_quad:  str   = "br",
        kaleido_sides: int = 8,
        crf:        int   = 18,
    ) -> None:
        try:
            os.makedirs(self.working_dir, exist_ok=True)
            self._log(f"Working dir: {self.working_dir}")
            self.update_stage(0)

            # Copy pipeline scripts into job dir so they run self-contained
            for fname in ("generate.sh", "generate_camogen_image.py", "apply_swirl.py"):
                src = os.path.join(SCRIPTS_DIR, fname)
                dst = os.path.join(self.working_dir, fname)
                shutil.copy2(src, dst)
                os.chmod(dst, 0o755)
                self._log(f"Copied {fname}")

            # Write mirror flag
            with open(os.path.join(self.working_dir, "mirror_q1.txt"), "w") as fh:
                fh.write("1" if self.mirror_q1 else "0")

            # Clamp parameters
            brightness = max(-127, min(127, brightness))
            contrast   = max(-127, min(127, contrast))
            duration   = max(10, min(3600, duration))
            crf        = max(0, min(51, crf))

            self.update_stage(1)

            env = os.environ.copy()
            env.update({
                "DURATION":      str(duration),
                "SCROLL_SPEED":  str(speed),
                "BRIGHTNESS":    str(brightness),
                "CONTRAST":      str(contrast),
                "COLORS":        ",".join(colors or ["red", "orange", "yellow", "green"]),
                "APPLY_KDEN":    "1" if apply_kden else "0",
                "FILL_MANDALA":  "1" if fill_mandala else "0",
                "SKIP_MIRROR":   "1" if skip_mirror else "0",
                "SEED_QUAD":     seed_quad,
                "KALEIDO_SIDES": str(kaleido_sides),
                "CRF":           str(crf),
            })

            generate_sh = os.path.join(self.working_dir, "generate.sh")
            self._log("Running generate.sh pipeline…")

            if self._cancelled:
                return

            # Stream stdout+stderr directly to the log file so [STEP X/Y]
            # labels appear in real time rather than only after completion.
            with open(self.log_path, "a") as _log_fh:
                self.proc = subprocess.Popen(
                    [generate_sh, self.working_dir],
                    cwd=self.working_dir,
                    env=env,
                    stdout=_log_fh,
                    stderr=_log_fh,
                )
                self.proc.wait()

            returncode = self.proc.returncode
            self.proc = None

            if self._cancelled:
                return

            if returncode != 0:
                raise subprocess.CalledProcessError(returncode, generate_sh)

            output = os.path.join(self.working_dir, "kaleido_output.mp4")
            if not os.path.exists(output):
                raise FileNotFoundError("kaleido_output.mp4 not produced by pipeline")

            self.output_file = output
            self.update_stage(5)
            self._log("Job completed successfully ✅")

        except subprocess.CalledProcessError as exc:
            if self._cancelled:
                return
            self.error  = f"Pipeline failed (exit {exc.returncode})"
            self.status = "failed"
            self._log(f"ERROR: {self.error}")
        except Exception as exc:
            if self._cancelled:
                return
            self.error  = str(exc)
            self.status = "failed"
            self._log(f"ERROR: {self.error}")
        else:
            if not self._cancelled:
                self.status   = "completed"
                self.progress = 100


# ---------------------------------------------------------------------------
# Routes
# ---------------------------------------------------------------------------
@app.route("/")
def index():
    return render_template("index.html")


@app.route("/start_render", methods=["POST"])
def start_render():
    job_id      = str(uuid.uuid4())
    mirror_q1   = request.form.get("mirror_q1") == "on"
    duration    = int(request.form.get("duration", 10))
    brightness  = int(request.form.get("brightness", 0))
    contrast    = int(request.form.get("contrast", 0))
    speed       = float(request.form.get("speed", 10))
    colors      = request.form.get("colors", "red,orange,yellow,green").split(",")
    apply_kden  = request.form.get("apply_kden") == "on"
    fill_mandala= request.form.get("fill_mandala") == "on"
    skip_mirror = request.form.get("skip_mirror") == "on"
    seed_quad   = request.form.get("seed_quad", "br")
    kaleido_sides = int(request.form.get("kaleido_sides", 8))
    crf         = int(request.form.get("crf", 18))

    job = RenderJob(job_id, mirror_q1=mirror_q1)
    jobs[job_id] = job

    threading.Thread(
        target=job.run,
        kwargs=dict(
            duration=duration,
            brightness=brightness,
            contrast=contrast,
            speed=speed,
            colors=colors,
            apply_kden=apply_kden,
            fill_mandala=fill_mandala,
            skip_mirror=skip_mirror,
            seed_quad=seed_quad,
            kaleido_sides=kaleido_sides,
            crf=crf,
        ),
        daemon=True,
    ).start()

    return jsonify({"job_id": job_id})


@app.route("/job_status/<job_id>")
def job_status(job_id: str):
    job = jobs.get(job_id)
    if job is None:
        return jsonify({"error": "Job not found"}), 404
    return jsonify({
        "status":      job.status,
        "progress":    job.progress,
        "output_file": job.output_file,
        "error":       job.error,
    })


@app.route("/job_log/<job_id>")
def job_log(job_id: str):
    job = jobs.get(job_id)
    if job is None:
        return jsonify({"error": "Job not found"}), 404
    try:
        with open(job.log_path) as fh:
            lines = fh.readlines()
        current_step = None
        for line in reversed(lines):
            m = re.search(r'\[STEP \d+/\d+\][^\n]*', line)
            if m:
                current_step = m.group(0).strip()
                break
        return jsonify({"log": lines, "current_step": current_step})
    except FileNotFoundError:
        return jsonify({"log": ["Log not yet created"], "current_step": None})


@app.route("/cancel/<job_id>", methods=["POST"])
def cancel_job(job_id: str):
    job = jobs.get(job_id)
    if job is None:
        return jsonify({"error": "Job not found"}), 404
    job.cancel()
    return jsonify({"status": "cancelled"})


@app.route("/download/<job_id>")
def download(job_id: str):
    job_path = os.path.join(JOBS_DIR, job_id, "kaleido_output.mp4")
    if os.path.exists(job_path):
        return send_file(job_path, as_attachment=True, download_name=f"kaleido_{job_id[:8]}.mp4")
    return "File not found", 404


@app.route("/server_load")
def server_load():
    if HAS_PSUTIL:
        return jsonify({"cpu": psutil.cpu_percent(interval=0.5)})
    return jsonify({"cpu": -1, "note": "psutil not installed"})


# ---------------------------------------------------------------------------
# Entry point
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port, debug=False)
