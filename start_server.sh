#!/usr/bin/env bash
# start_server.sh — Launch Gunicorn for Kaleidoscope Video Generator
# Usage: ./start_server.sh [port]
set -euo pipefail

PORT="${1:-5000}"
HOST="0.0.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
LOG_DIR="$SCRIPT_DIR/logs"
mkdir -p "$LOG_DIR"

# Ensure gunicorn is available
if ! command -v gunicorn &>/dev/null; then
  echo "❌  gunicorn not found — activate your virtualenv or run: pip install gunicorn"
  exit 1
fi

# Kill anything on the port
if PIDS=$(lsof -t -i :"$PORT" 2>/dev/null); then
  echo "⚠️  Port $PORT in use — stopping existing processes…"
  kill -9 $PIDS 2>/dev/null || true
  sleep 1
fi

echo "🚀  Starting on http://${HOST}:${PORT} …"
cd "$SRC_DIR"
exec gunicorn app:app \
  --bind "${HOST}:${PORT}" \
  --workers 1 \
  --timeout 600 \
  --log-level info \
  --access-logfile "$LOG_DIR/access.log" \
  --error-logfile  "$LOG_DIR/error.log"
