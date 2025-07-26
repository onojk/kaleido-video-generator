#!/bin/bash
FILE="$1"
MIN_KB=100

size=$(du -h "$FILE" | awk '{print $1}')
unit="${size//[0-9.]}"
value="${size//[!0-9.]}"

case "$unit" in
  K|KB|k|kB) min=$MIN_KB ;;
  M|MB|m|mB) min=0.1 ;;
  G|GB|g|gB) min=0.0001 ;;
  *) echo "[⚠️] Unknown size unit: $unit"; exit 1 ;;
esac

if awk "BEGIN {exit !($value >= $min)}"; then
  echo "[✅] Video render succeeded: $size"
else
  echo "[❌] Rendered file too small: $size"
  exit 1
fi
