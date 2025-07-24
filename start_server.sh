#!/bin/bash
# start_server.sh

# Exit on error
set -e

echo "🔍 Verifying patch_kdenlive_10s.py..."
if ! grep -q "def patch_project" patch_kdenlive_10s.py; then
    echo "❌ Missing or invalid patch_kdenlive_10s.py"
    exit 1
fi

echo "✅ patch_kdenlive_10s.py looks good"

echo "🧼 Cleaning up stale jobs..."
rm -rf jobs/*

echo "🚀 Starting Gunicorn server..."
nohup gunicorn app:app --bind 0.0.0.0:5000 --workers 2 --timeout 120 > gunicorn.log 2>&1 &

echo "📜 Tail log with: tail -f gunicorn.log"
