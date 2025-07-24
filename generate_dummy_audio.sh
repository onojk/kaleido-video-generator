#!/bin/bash
# Usage: ./generate_dummy_audio.sh /path/to/job_folder

JOB_FOLDER="$1"
ffmpeg -f lavfi -i anullsrc=r=48000:cl=stereo -t 10 "$JOB_FOLDER/dummy_silence.wav"
