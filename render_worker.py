import subprocess
import sys

def render(job_id, input_path, output_path):
    try:
        cmd = [
            "melt",
            input_path,
            "-filter", "frei0r.kaleid0sc0pe",
            "-consumer", f"avformat:{output_path}"
        ]
        
        process = subprocess.Popen(
            cmd,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            universal_newlines=True
        )
        
        while True:
            output = process.stdout.readline()
            if output == '' and process.poll() is not None:
                break
            if output:
                # Parse progress from melt output
                print(output.strip())
                
        return process.poll() == 0
    except Exception as e:
        print(f"Render error: {e}")
        return False

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: python render_worker.py JOB_ID INPUT_PATH OUTPUT_PATH")
        sys.exit(1)
        
    success = render(sys.argv[1], sys.argv[2], sys.argv[3])
    sys.exit(0 if success else 1)
