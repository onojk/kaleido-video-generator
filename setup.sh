#!/usr/bin/env bash
# setup.sh — First-time environment bootstrap
# Usage: bash setup.sh
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV="$SCRIPT_DIR/.venv"

echo "=== Kaleidoscope Video Generator — Setup ==="

# Create virtual environment
if [[ ! -d "$VENV" ]]; then
  echo "→  Creating virtual environment at $VENV"
  python3 -m venv "$VENV"
fi

source "$VENV/bin/activate"
pip install --upgrade pip --quiet
pip install -r "$SCRIPT_DIR/requirements.txt" --quiet
echo "✅  Python deps installed"

# Check system deps
MISSING=()
for cmd in ffmpeg convert python3; do
  command -v "$cmd" &>/dev/null || MISSING+=("$cmd")
done

if [[ ${#MISSING[@]} -gt 0 ]]; then
  echo ""
  echo "⚠️  Missing system dependencies: ${MISSING[*]}"
  echo "    On Ubuntu/Debian:"
  echo "      sudo apt install ffmpeg imagemagick"
else
  echo "✅  System deps OK (ffmpeg, convert, python3)"
fi

echo ""
echo "=== Setup complete ==="
echo "Run the server with:"
echo "  source .venv/bin/activate && ./start_server.sh"
