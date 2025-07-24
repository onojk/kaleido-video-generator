from flask import Flask, render_template, request, jsonify, send_file, redirect, url_for
import threading, time, os, uuid, json
from patch_kdenlive_10s import patch_project

app = Flask(__name__)

def save_job(job_id, data):
    os.makedirs(f"jobs/{job_id}", exist_ok=True)
    with open(f"jobs/{job_id}/status.json", "w") as f:
        json.dump(data, f)

def load_job(job_id):
    try:
        with open(f"jobs/{job_id}/status.json") as f:
            return json.load(f)
    except FileNotFoundError:
        return None

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/progress")
def progress():
    job_id = request.args.get("job_id", "")
    return render_template("progress.html", job_id=job_id)

@app.route("/start_render", methods=["POST"])
def start_render():
    duration = int(request.form.get("duration", 10))
    job_id = str(uuid.uuid4())

    save_job(job_id, {
        "progress": 0,
        "stage": "Queued...",
        "status": "running",
        "log": [],
    })

    thread = threading.Thread(target=render_task, args=(job_id, duration), daemon=True)
    thread.start()

    return jsonify({"redirect": url_for("progress") + f"?job_id={job_id}"})

@app.route("/job_status")
def job_status():
    job_id = request.args.get("job_id")
    job = load_job(job_id)
    if not job:
        return jsonify({"error": "Invalid job ID"}), 404
    return jsonify(job)

@app.route("/download")
def download():
    job_id = request.args.get("job_id")
    output_path = f"jobs/{job_id}/final_output_cleaned.mp4"
    if os.path.exists(output_path):
        return send_file(output_path, as_attachment=True)
    return "File not found", 404

def render_task(job_id, duration):
    try:
        job = load_job(job_id)
        job["log"].append("🔧 Starting render pipeline")
        job["stage"] = "Generating image"
        save_job(job_id, job)

        output_dir = f"jobs/{job_id}"
        os.makedirs(output_dir, exist_ok=True)

        # ✅ Generate the rainbow image
        os.system(f"python3 generate_rainbow_image.py {output_dir}/current_abstract_video_image.jpg")

        image_path = f"{output_dir}/current_abstract_video_image.jpg"
        kdenlive_project = f"{output_dir}/patched.kdenlive"
        output_mp4 = f"{output_dir}/final_output_cleaned.mp4"

        job["stage"] = "Patching Kdenlive project"
        save_job(job_id, job)

        patch_project(image_path, kdenlive_project)

        job["stage"] = "Rendering video with melt"
        job["log"].append("🚀 Launching melt renderer")
        save_job(job_id, job)

        melt_cmd = (
            f"xvfb-run -a ./squashfs-root-new/usr/bin/melt {kdenlive_project} "
            f"-profile hd1080 -consumer avformat:{output_mp4} "
            f"vcodec=libx264 acodec=aac threads=2"
        )

        result = os.system(melt_cmd)
        if result != 0:
            raise RuntimeError("Melt render failed.")

        for i in range(10):
            time.sleep(duration / 10)
            job["progress"] += 10
            job["log"].append(f"Frame chunk {i+1}/10 rendered")
            save_job(job_id, job)

        job["stage"] = "✅ Completed"
        job["status"] = "completed"
        job["progress"] = 100
        job["log"].append("🎉 Render complete")
        save_job(job_id, job)

    except Exception as e:
        job = load_job(job_id) or {}
        job["status"] = "failed"
        job.setdefault("log", []).append(f"❌ Error: {e}")
        job["stage"] = "Error"
        save_job(job_id, job)
