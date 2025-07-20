#!/usr/bin/env python3
import subprocess
import sys

def run_script(script_name):
    print(f"[🌀] Running: {script_name}")
    try:
        subprocess.run(["python3", script_name], check=True)
    except subprocess.CalledProcessError as e:
        print(f"[❌] {script_name} failed with exit code {e.returncode}")
        sys.exit(1)

def main():
    run_script("strip_orphan_and_audio_producers.py")
    run_script("fix_kdenlive_mlt_wrapper.py")
    run_script("render_next.py")

if __name__ == "__main__":
    main()
