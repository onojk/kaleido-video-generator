#!/bin/bash

# Activate virtual environment
source ~/kaleido-video-generator/venv/bin/activate

# Set frei0r path
export FREI0R_PATH=/usr/local/lib/frei0r-1

# Generate rainbow image
python generate_rainbow.py || {
    echo "Error: Failed to generate rainbow image"
    exit 1
}

# Render with melt
melt render_this.kdenlive || {
    echo "Error: Rendering failed"
    exit 1
}

deactivate  # Optional: deactivate virtualenv when done
echo "Rendering completed successfully"
