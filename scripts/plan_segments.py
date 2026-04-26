#!/usr/bin/env python3
"""
plan_segments.py — Compute parallel render segment specs for generate.sh.

Reads geometry from env vars, writes to stdout:
  TOTAL_SEGS=N
  idx|src_path|x_ffmpeg_expr|chunk_dur_seconds|output_path
  ...

Each sub-segment is a fixed-length slice of a full L2R or R2L sweep.
The x_ffmpeg_expr is a valid FFmpeg filter expression (uses `t` for frame time).
"""
import os, sys

def env(name, cast=str, default=None):
    v = os.environ.get(name, "")
    if v == "":
        if default is not None:
            return cast(default)
        print(f"ERROR: {name} not set", file=sys.stderr)
        sys.exit(1)
    return cast(v)

seg_len     = env("SEG_LEN",     float)          # seconds for one full L2R or R2L sweep
chunk       = max(1.0, env("SEGMENT_LEN", float, 30))  # max seconds per parallel chunk
duration    = env("DURATION",    float)
loops       = env("LOOPS",       int)
total_w     = env("TOTAL_W",     int)             # panorama pixel width
out_w       = env("OW",          int)             # output frame width
segs_dir    = env("SEGS_DIR",    str)
src_l2r     = env("SRC_L2R",     str)
src_r2l     = env("SRC_R2L",     str)

# pixels per second during a sweep
vel = (total_w - out_w) / seg_len if seg_len > 1e-9 else 0.0

specs = []
idx = 0

for s in range(loops * 2):
    direction = "L2R" if s % 2 == 0 else "R2L"
    src = src_l2r if direction == "L2R" else src_r2l
    t_sweep = 0.0

    while t_sweep < seg_len - 1e-6:
        abs_start = s * seg_len + t_sweep
        if abs_start >= duration - 1e-6:
            break

        rem_sweep = seg_len - t_sweep
        rem_total = duration - abs_start
        chunk_dur = min(chunk, rem_sweep, rem_total)
        if chunk_dur < 0.01:
            break

        if direction == "L2R":
            x_start = t_sweep * vel
            x_expr  = f"{x_start:.4f}+(t*{vel:.4f})"
        else:
            x_start = (total_w - out_w) - t_sweep * vel
            x_expr  = f"{x_start:.4f}-(t*{vel:.4f})"

        out_path = f"{segs_dir}/seg_{idx:05d}.mp4"
        specs.append(f"{idx}|{src}|{x_expr}|{chunk_dur:.4f}|{out_path}")
        idx += 1
        t_sweep += chunk_dur

print(f"TOTAL_SEGS={idx}")
for spec in specs:
    print(spec)
