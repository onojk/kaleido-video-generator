#!/usr/bin/env bash
# Kaleido generator — pan + pivot swirls, optional Frei0r radial kaleidoscope,
# and a quadrant->mirror mandala fill from a chosen seed quadrant.
set -euo pipefail

# -------------------- helpers --------------------
resolve_script() {
  local name="$1" cand
  for cand in "$WORKDIR/$name" "$WORKDIR/../../$name" "$WORKDIR/../$name" "$HOME/kaleido-video-generator/$name" "./$name"; do
    [[ -f "$cand" ]] && { echo "$cand"; return 0; }
  done
  echo "$name"
}
log() { [[ "${VERBOSE:-1}" = "1" ]] && echo "$*"; }
run_or_echo() {
  if [[ "${DRY_RUN:-0}" = "1" ]]; then printf '[DRY_RUN] %q ' "$@"; echo; else "$@"; fi
}

# -------------------- config (env overrides) --------------------
WORKDIR="${1:-$(pwd)}"
VERBOSE="${VERBOSE:-1}"
DRY_RUN="${DRY_RUN:-0}"
FAST_PREVIEW="${FAST_PREVIEW:-0}"
REUSE_BASE="${REUSE_BASE:-0}"
SKIP_SWIRL="${SKIP_SWIRL:-0}"
SKIP_CAMO_SWIRL="${SKIP_CAMO_SWIRL:-0}"
SKIP_MIRROR="${SKIP_MIRROR:-0}"
KEEP_TMP="${KEEP_TMP:-0}"

BRIGHTNESS="${BRIGHTNESS:-0}"
CONTRAST="${CONTRAST:-0}"
DURATION="${DURATION:-30}"
FPS="${FPS:-30}"
CRF="${CRF:-18}"
PRESET="${PRESET:-medium}"
SCROLL_SPEED="${SCROLL_SPEED:-0.02}"
SWIRL_PASSES="${SWIRL_PASSES:-2}"
PIX_FMT="${PIX_FMT:-yuv420p}"

# Parallel rendering
SEGMENT_LEN="${SEGMENT_LEN:-30}"   # max seconds per parallel render chunk
WORKERS="${WORKERS:-$(( $(nproc) / 2 ))}"
(( WORKERS < 1 )) && WORKERS=1
(( WORKERS > 8 )) && WORKERS=8

# Radial kaleidoscope (Frei0r) — KALEIDO_SIDES is the number of wedges;
# normalized internally as sides/128 for the frei0r segmentation parameter.
APPLY_KDEN="${APPLY_KDEN:-0}"      # 1 = apply frei0r=kaleid0sc0pe before quadrants
KALEIDO_SIDES="${KALEIDO_SIDES:-12}"
KALEIDO_ORIGIN_X="${KALEIDO_ORIGIN_X:-0.5}"   # sample origin x (0.0–1.0, default center)
KALEIDO_ORIGIN_Y="${KALEIDO_ORIGIN_Y:-0.5}"   # sample origin y (0.0–1.0, default center)

# Quadrant->mirror mandala fill
FILL_MANDALA="${FILL_MANDALA:-0}"  # 1 = do the quadrant clone/mirror tiling
SEED_QUAD="${SEED_QUAD:-br}"       # tl | tr | bl | br  (seed quadrant to crop)

# Panorama sizing for pan segments
EXTRA_CAP="${EXTRA_CAP:-12288}"
MIN_EXTRA="${MIN_EXTRA:-512}"

# -------------------- paths --------------------
TMP="$WORKDIR/tmp"; mkdir -p "$TMP"
GEN_CAMO="$(resolve_script generate_camogen_image.py)"
APPLY_SWIRL_FAST="$(resolve_script apply_swirl_fast.py)"
APPLY_SWIRL="$(resolve_script apply_swirl.py)"
SWIRL_SCRIPT="$APPLY_SWIRL"
[[ -f "$APPLY_SWIRL_FAST" ]] && SWIRL_SCRIPT="$APPLY_SWIRL_FAST"

# Install GNU parallel if absent (needed for multi-core segment rendering)
if ! command -v parallel &>/dev/null; then
  echo "[INFO] Installing GNU parallel for multi-core rendering..."
  sudo apt-get install -y parallel 2>/dev/null || true
fi

# Output resolution from quality preset (WIDTH/HEIGHT passed by app.py)
WIDTH="${WIDTH:-1920}"
HEIGHT="${HEIGHT:-1080}"
IS_PREVIEW="${IS_PREVIEW:-0}"
RAW_VIDEO_SRC="${RAW_VIDEO_SRC:-}"
OW="$WIDTH"
OH="$HEIGHT"

# Auto-optimize for short renders — only auto-enable FAST_PREVIEW on preview presets
if (( DURATION <= 30 )) && [[ "$IS_PREVIEW" = "1" ]] && [[ "$FAST_PREVIEW" = "0" ]]; then
  FAST_PREVIEW=1
  echo "[INFO] Auto-enabling FAST_PREVIEW for ${DURATION}s preview render"
fi
if (( DURATION <= 30 )); then
  SKIP_SWIRL=1           # skip side-bake swirl during segment generation
  SKIP_CAMO_SWIRL=1      # skip swirl on the initial camo image
fi
if (( DURATION <= 30 )) && (( SWIRL_PASSES > 1 )); then SWIRL_PASSES=1; fi
if (( DURATION < 60 )) && (( EXTRA_CAP > 4096 )); then EXTRA_CAP=4096; fi

# Auto-set NUM_SHAPES based on duration
if [[ -z "${NUM_SHAPES:-}" ]]; then
  if (( DURATION <= 30 )); then NUM_SHAPES=600
  else NUM_SHAPES=1000; fi
fi
export NUM_SHAPES

# FAST_PREVIEW tweaks (preset already set by app.py for preview modes)
if [[ "$FAST_PREVIEW" = "1" ]]; then PRESET="ultrafast"; CRF="26"; FPS="24"; fi

echo "[INFO] PivotSwirls DURATION=${DURATION}s • FPS $FPS • FAST_PREVIEW=$FAST_PREVIEW"
log  "[INFO] Workdir: $WORKDIR"
log  "[INFO] Using: GEN_CAMO=$GEN_CAMO  SWIRL_SCRIPT=$SWIRL_SCRIPT"

if [[ -z "$RAW_VIDEO_SRC" ]]; then

# -------------------- step 1: build base image --------------------
_T=$SECONDS
if [[ "$REUSE_BASE" = "1" && -f "$TMP/base.jpg" ]]; then
  echo "[STEP 1/8] Reusing cached base image"
else
  echo "[STEP 1/8] Generating camo base image (${NUM_SHAPES} shapes)..."
  run_or_echo python3 "$GEN_CAMO" "$TMP/camo_raw.jpg"
  echo "[TIMING] Step 1 done in $(( SECONDS - _T ))s"; _T=$SECONDS

  if [[ "$SKIP_CAMO_SWIRL" = "1" ]]; then
    echo "[STEP 2/8] Skipping swirl (fast mode — copying raw image)..."
    run_or_echo cp "$TMP/camo_raw.jpg" "$TMP/camo.jpg"
  else
    echo "[STEP 2/8] Applying swirl distortion (${SWIRL_PASSES} pass(es))..."
    run_or_echo python3 "$SWIRL_SCRIPT" "$TMP/camo_raw.jpg" "$TMP/camo.jpg"
  fi
  echo "[TIMING] Step 2 done in $(( SECONDS - _T ))s"; _T=$SECONDS

  echo "[STEP 3/8] Upscaling to ${OW}x${OH} with ImageMagick..."
  run_or_echo convert "$TMP/camo.jpg" -brightness-contrast ${BRIGHTNESS}x${CONTRAST} -resize "${OW}x${OH}!" -quality 100 "$TMP/base.jpg"
  echo "[TIMING] Step 3 done in $(( SECONDS - _T ))s"
fi

# -------------------- step 2: make wide pano --------------------
_T=$SECONDS; echo "[STEP 4/8] Building wide panorama (${OW}x${OH})..."
EXTRA_WIDTH="$(awk -v d="$DURATION" -v s="$SCROLL_SPEED" -v cap="$EXTRA_CAP" -v mn="$MIN_EXTRA" -v ow="$OW" 'BEGIN{w=int(d*s*ow); if(w<mn) w=mn; if(w>cap) w=cap; print w}')"
TOTAL_W=$(($OW + EXTRA_WIDTH))
H=$OH
echo "[INFO] TOTAL_W=$TOTAL_W (EXTRA=$EXTRA_WIDTH) res=${OW}x${OH}"
run_or_echo convert "$TMP/base.jpg" -resize "${TOTAL_W}x${H}!" -quality 100 "$TMP/wide_base.jpg"

SPEED_PPS="$(awk -v s="$SCROLL_SPEED" -v ow="$OW" 'BEGIN{v=s*ow; if(v<=0) v=1; printf "%.6f", v}')"
iw="$TOTAL_W"; ow=$OW
SEG_LEN="$(awk -v iw="$iw" -v ow="$ow" -v v="$SPEED_PPS" -v dur="$DURATION" 'BEGIN{ len=(v<=0)?1e9:(iw-ow)/v; if(len<4) len=4; if(len>dur) len=dur; printf "%.3f", len }')"
PAIR_LEN="$(awk -v sl="$SEG_LEN" 'BEGIN{printf "%.3f", 2*sl}')"
LOOPS="$(awk -v dur="$DURATION" -v pair="$PAIR_LEN" 'BEGIN{n=int((dur+pair-0.001)/pair); if(n<1)n=1; print n}')"
echo "[INFO] SEG_LEN=${SEG_LEN}s • LOOPS=$LOOPS (pair=${PAIR_LEN}s)"
echo "[TIMING] Step 4 done in $(( SECONDS - _T ))s"

# Mask maker (used by side-swirl bake)
make_side_mask() {
  local side="${1?side}"; local mask="${2?mask}"
  if [[ "$side" = "left" ]]; then
    run_or_echo convert -size ${TOTAL_W}x${H} xc:black -fill white -draw "rectangle 0,0 $(( (TOTAL_W-ow)/2 - 1 )),$((H-1))" "$mask"
  else
    run_or_echo convert -size ${TOTAL_W}x${H} xc:black -fill white -draw "rectangle $(( (TOTAL_W+ow)/2 )),0 $(( TOTAL_W-1 )),$((H-1))" "$mask"
  fi
}
bake_side_swirl() {
  local side="${1?side}"; local out="${2?output}"
  local mask="$TMP/mask_${side}.png"
  make_side_mask "$side" "$mask"
  run_or_echo python3 "$SWIRL_SCRIPT" "$TMP/wide_base.jpg" "$TMP/_sw1.jpg"
  if [[ "$SWIRL_PASSES" = "1" ]]; then cp "$TMP/_sw1.jpg" "$TMP/_sw2.jpg"; else run_or_echo python3 "$SWIRL_SCRIPT" "$TMP/_sw1.jpg" "$TMP/_sw2.jpg"; fi
  run_or_echo ffmpeg -y -loglevel warning \
    -loop 1 -t 0.04 -i "$TMP/wide_base.jpg" \
    -loop 1 -t 0.04 -i "$TMP/_sw2.jpg" \
    -loop 1 -t 0.04 -i "$mask" \
    -filter_complex "[1][2]alphamerge[sw];[0][sw]overlay[out]" \
    -map "[out]" -frames:v 1 "$out" >/dev/null 2>&1
  [[ -f "$out" ]] || run_or_echo cp "$TMP/_sw2.jpg" "$out"
}
render_segment() {
  local dir="${1?dir}"; local src="${2?src}"; local out="${3?out}"
  if [[ "$dir" = "L2R" ]]; then
    run_or_echo ffmpeg -y -loglevel warning -loop 1 -i "$src" \
      -vf "crop=${OW}:${OH}:x=t*(${iw}-${ow})/${SEG_LEN}:y=0" \
      -t "$SEG_LEN" -r "$FPS" -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" "$out"
  else
    run_or_echo ffmpeg -y -loglevel warning -loop 1 -i "$src" \
      -vf "crop=${OW}:${OH}:x=(${iw}-${ow})-t*(${iw}-${ow})/${SEG_LEN}:y=0" \
      -t "$SEG_LEN" -r "$FPS" -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" "$out"
  fi
}

# ── Swirl pre-bake (once, shared by all parallel workers) ───────────────────
_T=$SECONDS
if [[ "$SKIP_SWIRL" != "1" ]]; then
  echo "[INFO] Pre-baking swirled sources (L2R + R2L)..."
  bake_side_swirl "right" "$TMP/wide_swirl_L2R.jpg"
  bake_side_swirl "left"  "$TMP/wide_swirl_R2L.jpg"
  SRC_L2R="$TMP/wide_swirl_L2R.jpg"
  SRC_R2L="$TMP/wide_swirl_R2L.jpg"
else
  SRC_L2R="$TMP/wide_base.jpg"
  SRC_R2L="$TMP/wide_base.jpg"
fi

# ── Segment cache (keyed to base image + encoding params) ───────────────────
BASE_HASH=$(md5sum "$TMP/wide_base.jpg" 2>/dev/null | cut -c1-8 || echo "nohash")
PARAMS_HASH=$(printf '%s' "${OW}x${OH}|${CRF}|${PRESET}|${FPS}|${SCROLL_SPEED}|${SEGMENT_LEN}|${SKIP_SWIRL}" | md5sum | cut -c1-8)
CACHE_KEY="${BASE_HASH}_${PARAMS_HASH}"
SEGS_DIR="$TMP/segs/${CACHE_KEY}"
mkdir -p "$SEGS_DIR"
echo "[INFO] Segment cache: $CACHE_KEY"

# ── Plan segments via Python helper ─────────────────────────────────────────
SEG_SPECS="$TMP/seg_specs.txt"
export SEG_LEN SEGMENT_LEN DURATION LOOPS TOTAL_W OW OH SEGS_DIR SRC_L2R SRC_R2L
python3 "$(resolve_script plan_segments.py)" > "$SEG_SPECS"

TOTAL_SEGS=$(grep '^TOTAL_SEGS=' "$SEG_SPECS" | cut -d= -f2)
echo "[STEP 5/8] Parallel segment render: ${TOTAL_SEGS} segments × ≤${SEGMENT_LEN}s, ${WORKERS} worker(s)..."

# ── Generate one runner script per segment ───────────────────────────────────
RUNNERS_DIR="$TMP/runners"; mkdir -p "$RUNNERS_DIR"
CONCAT_LIST="$TMP/concat_segs.txt"; : > "$CONCAT_LIST"
RUNNERS=()

while IFS='|' read -r _idx _src _xexpr _cdur _out; do
  [[ "$_idx" =~ ^[0-9] ]] || continue
  echo "file '$_out'" >> "$CONCAT_LIST"
  _runner="$RUNNERS_DIR/$(printf 'run_%05d.sh' "$_idx")"
  cat > "$_runner" << RUNNER_EOF
#!/usr/bin/env bash
if [[ -f '${_out}' ]]; then echo "[SEG ${_idx}/${TOTAL_SEGS} cached]"; exit 0; fi
ffmpeg -y -loglevel warning -loop 1 -i '${_src}' -vf "crop=${OW}:${OH}:x=${_xexpr}:y=0" -t ${_cdur} -r ${FPS} -c:v libx264 -preset ${PRESET} -crf ${CRF} -pix_fmt ${PIX_FMT} '${_out}'
echo "[SEG ${_idx}/${TOTAL_SEGS}]"
RUNNER_EOF
  chmod +x "$_runner"
  RUNNERS+=("$_runner")
done < "$SEG_SPECS"

# ── Dispatch ─────────────────────────────────────────────────────────────────
if [[ "$DRY_RUN" = "1" ]]; then
  echo "[DRY_RUN] Would dispatch ${#RUNNERS[@]} segment runners with $WORKERS workers"
elif command -v parallel &>/dev/null && (( WORKERS > 1 )); then
  parallel --line-buffer -j"$WORKERS" bash ::: "${RUNNERS[@]}"
else
  _pids=()
  for _r in "${RUNNERS[@]}"; do
    bash "$_r" &
    _pids+=($!)
    if (( ${#_pids[@]} >= WORKERS )); then
      wait "${_pids[0]}" 2>/dev/null || true
      _pids=("${_pids[@]:1}")
    fi
  done
  (( ${#_pids[@]} > 0 )) && wait "${_pids[@]}" 2>/dev/null || true
fi
echo "[TIMING] Step 5 done in $(( SECONDS - _T ))s"

# ── Step 6: concat pre-trimmed segments (no re-encode needed) ────────────────
_T=$SECONDS; echo "[STEP 6/8] Concatenating ${TOTAL_SEGS} segments → pan_final.mp4..."
run_or_echo ffmpeg -y -loglevel warning -f concat -safe 0 -i "$CONCAT_LIST" -c copy "$TMP/pan_final.mp4"
echo "[TIMING] Step 6 done in $(( SECONDS - _T ))s"
  SOURCE_FOR_MANDALA="$TMP/pan_final.mp4"

else
  # RAW_VIDEO_SRC path: bypass camo/swirl/pan/segments entirely
  echo "[INFO] RAW_VIDEO_SRC=${RAW_VIDEO_SRC} — bypassing steps 1-6"
  if ! command -v ffprobe &>/dev/null; then
    echo "[ERROR] ffprobe required for RAW_VIDEO_SRC dimension check but not found" >&2; exit 1
  fi
  _src_w=$(ffprobe -v error -select_streams v:0 -show_entries stream=width  -of csv=p=0 "$RAW_VIDEO_SRC" 2>/dev/null || echo 0)
  _src_h=$(ffprobe -v error -select_streams v:0 -show_entries stream=height -of csv=p=0 "$RAW_VIDEO_SRC" 2>/dev/null || echo 0)
  if [[ "$_src_w" != "$OW" || "$_src_h" != "$OH" ]]; then
    echo "[ERROR] RAW_VIDEO_SRC resolution ${_src_w}x${_src_h} != pipeline ${OW}x${OH}. Aborting." >&2
    exit 1
  fi
  SOURCE_FOR_MANDALA="$RAW_VIDEO_SRC"
  # Satisfy -u for variables set inside the skipped steps 1-6
  TOTAL_W=0; SEG_LEN=0; LOOPS=0; TOTAL_SEGS=0; SKIP_SWIRL=1

fi # end RAW_VIDEO_SRC bypass

# Returns 0 if frei0r kaleid0sc0pe is usable, 1 otherwise
_frei0r_available() {
  ffmpeg -hide_banner -filters 2>/dev/null | grep -iq "kaleid" && return 0
  local _p
  for _p in /usr/lib/frei0r-1/kaleid0sc0pe.so /usr/local/lib/frei0r-1/kaleid0sc0pe.so; do
    [[ -f "$_p" ]] && return 0
  done
  return 1
}

SEG_NORMALIZED=$(awk -v s="$KALEIDO_SIDES" 'BEGIN{printf "%.6f", s/128}')

_T=$SECONDS; echo "[STEP 7/8] Applying effects and writing output..."
# -------------------- optional Frei0r radial kaleidoscope --------------------
if _frei0r_available; then
  if [[ "$APPLY_KDEN" = "1" ]]; then
    log "🧪 Applying Frei0r radial kaleid0sc0pe (${KALEIDO_SIDES} wedges, origin ${KALEIDO_ORIGIN_X}|${KALEIDO_ORIGIN_Y})…"
    run_or_echo ffmpeg -y -loglevel warning -i "$SOURCE_FOR_MANDALA" \
      -vf "format=rgba,frei0r=filter_name=kaleid0sc0pe:filter_params=${KALEIDO_ORIGIN_X}|${KALEIDO_ORIGIN_Y}|${SEG_NORMALIZED},format=${PIX_FMT}" \
      -r "$FPS" "$TMP/kden_k${KALEIDO_SIDES}.mp4"
    SOURCE_FOR_MANDALA="$TMP/kden_k${KALEIDO_SIDES}.mp4"
  else
    log "[WARN] frei0r present but APPLY_KDEN=0 — skipping radial kaleidoscope"
  fi
else
  log "[WARN] frei0r NOT available — skipping radial kaleidoscope"
fi

# -------------------- step 4: optional 2×2 mirror --------------------
MIRROR_SOURCE="$SOURCE_FOR_MANDALA"
if [[ "$SKIP_MIRROR" != "1" ]]; then
  log "🧩 Applying 2×2 mirror…"
  run_or_echo ffmpeg -y -loglevel warning -i "$SOURCE_FOR_MANDALA" \
    -filter_complex "[0:v]crop=iw/2:ih/2:iw/2:ih/2,split=4[q1][q2][q3][q4]; \
                     [q2]hflip[q2h]; \
                     [q3]vflip[q3v]; \
                     [q4]hflip, vflip[q4hv]; \
                     [q1][q2h]hstack=inputs=2[top]; \
                     [q3v][q4hv]hstack=inputs=2[bottom]; \
                     [top][bottom]vstack=inputs=2[outv]" \
    -map "[outv]" -r "$FPS" -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" \
    "$TMP/mirror2x2.mp4"
  MIRROR_SOURCE="$TMP/mirror2x2.mp4"
fi

# -------------------- step 5: quadrant→mirror mandala fill --------------------
OUTPUT="$WORKDIR/kaleido_output.mp4"
FINAL_SOURCE="$MIRROR_SOURCE"

if [[ "$FILL_MANDALA" = "1" ]]; then
  log "🧿 Mandala fill from seed quadrant: $SEED_QUAD"
  # choose crop for the seed quadrant
  case "$SEED_QUAD" in
    br) CROP="iw/2:ih/2:iw/2:ih/2" ;;
    bl) CROP="iw/2:ih/2:0:ih/2"    ;;
    tr) CROP="iw/2:ih/2:iw/2:0"    ;;
    tl) CROP="iw/2:ih/2:0:0"       ;;
    *)  echo "Unknown SEED_QUAD '$SEED_QUAD' (use tl|tr|bl|br)"; exit 1 ;;
  esac
  # Build the quad by flipping the seed tile into the 3 other slots.
  read -r -d '' FILTER_GRAPH <<'EOF'
[0:v]format=rgba,crop=${CROP},split=3[tile][hsrc][vsrc];
[hsrc]hflip[h];
[vsrc]vflip[v];
[h][tile]hstack=inputs=2[top];
[v][tile]hstack=inputs=2[bottom];
[top][bottom]vstack=inputs=2[full];
[full]format=${PIX_FMT}[outv]
EOF
    -filter_complex "$FILTER_GRAPH" \
    -map "[outv]" -r "$FPS" -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" \
    "$OUTPUT"
else
  log "[INFO] Skipping mandala fill; writing source to output"
  run_or_echo cp -f "$FINAL_SOURCE" "$OUTPUT"
fi

# -------------------- cleanup --------------------
if [[ "$KEEP_TMP" != "1" && "$DRY_RUN" != "1" ]]; then
  find "$TMP" -maxdepth 1 -type f ! -name 'base.jpg' ! -name 'wide_base.jpg' \
       ! -name 'pan_final.mp4' -delete || true
fi

SWIRL_COUNT=$(( SKIP_SWIRL==1 ? 0 : 2*LOOPS ))
FREI0R_APPLIED=$(( APPLY_KDEN==1 ? 1 : 0 ))
MANDALA_APPLIED=$(( FILL_MANDALA==1 ? 1 : 0 ))
echo "[TIMING] Step 7 done in $(( SECONDS - _T ))s"

# -------------------- step 8: frei0r kaleidoscope final pass --------------------
KALEIDO_APPLIED=0
_T=$SECONDS; echo "[STEP 8/8] Applying frei0r kaleidoscope (${KALEIDO_SIDES} sides) to final output..."

if ! _frei0r_available; then
  echo "[INFO] frei0r not found — attempting: sudo apt-get install -y frei0r-plugins"
  if [[ "$DRY_RUN" = "1" ]]; then
    echo "[DRY_RUN] sudo apt-get install -y frei0r-plugins"
  else
    sudo apt-get install -y frei0r-plugins 2>&1 || true
  fi
fi

if _frei0r_available; then
  KALEIDO_TMP="$TMP/kaleido_k${KALEIDO_SIDES}.mp4"
  echo "[INFO] Running kaleid0sc0pe (${KALEIDO_SIDES} wedges, origin ${KALEIDO_ORIGIN_X}|${KALEIDO_ORIGIN_Y}) on $(basename "$OUTPUT")..."
  run_or_echo ffmpeg -y -loglevel warning \
    -i "$OUTPUT" \
    -vf "format=rgba,frei0r=filter_name=kaleid0sc0pe:filter_params=${KALEIDO_ORIGIN_X}|${KALEIDO_ORIGIN_Y}|${SEG_NORMALIZED},format=${PIX_FMT}" \
    -r "$FPS" -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" \
    "$KALEIDO_TMP"
  if [[ "$DRY_RUN" = "1" ]] || [[ -f "$KALEIDO_TMP" ]]; then
    run_or_echo mv -f "$KALEIDO_TMP" "$OUTPUT"
    echo "[INFO] kaleid0sc0pe applied → $(basename "$OUTPUT")"
    KALEIDO_APPLIED=1
  else
    echo "[WARN] frei0r produced no output — keeping existing $(basename "$OUTPUT")"
  fi
else
  echo "[WARN] frei0r kaleid0sc0pe not available — skipping step 8, output unchanged"
fi
echo "[TIMING] Step 8 done in $(( SECONDS - _T ))s"

echo "[TIMING] Total pipeline: ${SECONDS}s"
echo "[OK] ${DURATION}s • FPS ${FPS} • res ${OW}x${OH} • width ${TOTAL_W} • seg ${SEG_LEN}s • pivots $((2*LOOPS)) • side-swirls ${SWIRL_COUNT} • frei0r ${FREI0R_APPLIED} • kaleid0sc0pe ${KALEIDO_APPLIED}(${KALEIDO_SIDES}sides) • mirror $((SKIP_MIRROR==1?0:1)) • mandala ${MANDALA_APPLIED} → $(basename "$OUTPUT")"
