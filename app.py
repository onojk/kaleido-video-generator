from flask import Flask, render_template, request, jsonify, send_file
import os
import threading
import uuid
import json
import shutil
import subprocess
import time
from PIL import Image, ImageDraw

app = Flask(__name__)
os.makedirs("jobs", exist_ok=True)

# ========== Helpers ==========

def write_status(job_id, progress, stage, status, error_msg=None):
    status_path = f"jobs/{job_id}/status.json"
    data = {
        "progress": progress,
        "stage": stage,
        "status": status
    }
    if error_msg:
        data["error"] = error_msg
    with open(status_path, "w") as f:
        json.dump(data, f)

def prepare_media(job_id):
    """Create a placeholder image for testing if none exists"""
    job_dir = f"jobs/{job_id}"
    image_path = f"{job_dir}/current_image.jpg"
    if not os.path.exists(image_path):
        img = Image.new("RGB", (1920, 1080), color=(255, 0, 255))
        draw = ImageDraw.Draw(img)
        draw.text((100, 100), f"Render Test {job_id[:8]}", fill=(0, 0, 0))
        img.save(image_path, "JPEG")
    return image_path

# ========== Background Worker ==========

def simulate_render(job_id):
    try:
        job_dir = f"jobs/{job_id}"
        image_path = prepare_media(job_id)
        output_path = f"{job_dir}/final_output.mp4"

        if not os.path.exists(image_path):
            raise RuntimeError(f"Input image missing: {image_path}")
        if os.path.getsize(image_path) == 0:
            raise RuntimeError("Input image is 0 bytes")

        # Simulate progress while rendering
        for i in range(1, 51):
            time.sleep(0.05)
            write_status(job_id, i * 2, f"Processing frame {i}/50", "processing")

        # Run melt (actual render)
        cmd = [
            "/usr/bin/melt",
            image_path,
            "-profile", "hd1080p60",
            "-consumer", f"avformat:{output_path}",
            "vcodec=libx264",
            "acodec=aac",
            "r=60",
            "threads=2"
        ]

        print(f"🚀 Running melt: {' '.join(cmd)}")
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            check=True
        )

        # Confirm file created
        if not os.path.exists(output_path) or os.path.getsize(output_path) == 0:
            raise RuntimeError("Melt completed but output file missing or 0 bytes")

        write_status(job_id, 100, "Render complete", "complete")

    except subprocess.CalledProcessError as e:
        error_msg = f"FFmpeg failed: {e.stderr}"
        print("❌", error_msg)
        write_status(job_id, 0, "Encoding failed", "error", error_msg)

    except Exception as e:
        print(f"❌ Unexpected error: {str(e)}")
        write_status(job_id, 0, "Render failed", "error", str(e))

# ========== API Routes ==========

@app.route("/api/render", methods=["POST"])
def start_render():
    job_id = str(uuid.uuid4())
    job_dir = f"jobs/{job_id}"
    os.makedirs(job_dir, exist_ok=True)

    write_status(job_id, 0, "Starting render...", "processing")
    threading.Thread(target=simulate_render, args=(job_id,), daemon=True).start()
    return jsonify({"job_id": job_id})

@app.route("/api/status/<job_id>")
def get_status(job_id):
    try:
        with open(f"jobs/{job_id}/status.json") as f:
            return jsonify(json.load(f))
    except FileNotFoundError:
        return jsonify({
            "status": "error",
            "message": "Job not found"
        }), 404

@app.route("/api/download/<job_id>")
def download(job_id):
    path = f"jobs/{job_id}/final_output.mp4"
    if os.path.exists(path):
        return send_file(path, as_attachment=True)
    return "Not ready", 404

# ========== Frontend Routes ==========

@app.route("/")
def index():
    return render_template("index.html")

# ========== Run ==========

if __name__ == "__main__":
    app.run(debug=True, port=5000)
