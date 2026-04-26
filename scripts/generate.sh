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

# Radial kaleidoscope (Frei0r) + sides count (8 is classic)
APPLY_KDEN="${APPLY_KDEN:-0}"      # 1 = apply frei0r=kaleid0sc0pe before quadrants
KALEIDO_SIDES="${KALEIDO_SIDES:-12}"

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

# Output resolution from quality preset (WIDTH/HEIGHT passed by app.py)
WIDTH="${WIDTH:-1920}"
HEIGHT="${HEIGHT:-1080}"
IS_PREVIEW="${IS_PREVIEW:-0}"
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

# Build alternating segments
_T=$SECONDS; echo "[STEP 5/8] Rendering pan segments (${LOOPS} loop(s), ${SEG_LEN}s each, swirl=${SKIP_SWIRL})..."
LIST="$TMP/list.txt"; : > "$LIST"
for ((i=0;i<LOOPS;i++)); do
  if [[ "$SKIP_SWIRL" = "1" ]]; then SRC_A="$TMP/wide_base.jpg"; else bake_side_swirl "right" "$TMP/wide_next_A.png"; SRC_A="$TMP/wide_next_A.png"; fi
  render_segment "L2R" "$SRC_A" "$TMP/seg_${i}_A.mp4"; echo "file '$TMP/seg_${i}_A.mp4'" >> "$LIST"

  if [[ "$SKIP_SWIRL" = "1" ]]; then SRC_B="$TMP/wide_base.jpg"; else bake_side_swirl "left" "$TMP/wide_next_B.png";  SRC_B="$TMP/wide_next_B.png";  fi
  render_segment "R2L" "$SRC_B" "$TMP/seg_${i}_B.mp4"; echo "file '$TMP/seg_${i}_B.mp4'" >> "$LIST"
done
echo "[TIMING] Step 5 done in $(( SECONDS - _T ))s"

_T=$SECONDS; echo "[STEP 6/8] Assembling final video (${DURATION}s, ${FPS}fps, CRF ${CRF})..."
run_or_echo ffmpeg -y -loglevel warning -f concat -safe 0 -i "$LIST" -c copy "$TMP/pair_loop.mp4"
run_or_echo ffmpeg -y -loglevel warning -i "$TMP/pair_loop.mp4" -t "$DURATION" \
  -c:v libx264 -preset "$PRESET" -crf "$CRF" -pix_fmt "$PIX_FMT" "$TMP/pan_final.mp4"
echo "[TIMING] Step 6 done in $(( SECONDS - _T ))s"

_T=$SECONDS; echo "[STEP 7/8] Applying effects and writing output..."
# -------------------- step 3: optional Frei0r radial kaleidoscope --------------------
SOURCE_FOR_MANDALA="$TMP/pan_final.mp4"
if ffmpeg -hide_banner -filters 2>/dev/null | grep -q "frei0r"; then
  if [[ "$APPLY_KDEN" = "1" ]]; then
    log "🧪 Applying Frei0r radial kaleid0sc0pe (${KALEIDO_SIDES} wedges)…"
    run_or_echo ffmpeg -y -loglevel warning -i "$TMP/pan_final.mp4" \
      -vf "format=rgba,frei0r=kaleid0sc0pe:${KALEIDO_SIDES},format=${PIX_FMT}" \
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

# Returns 0 if frei0r kaleid0sc0pe is usable, 1 otherwise
_frei0r_available() {
  ffmpeg -hide_banner -filters 2>/dev/null | grep -iq "kaleid" && return 0
  local _p
  for _p in /usr/lib/frei0r-1/kaleid0sc0pe.so /usr/local/lib/frei0r-1/kaleid0sc0pe.so; do
    [[ -f "$_p" ]] && return 0
  done
  return 1
}

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
  echo "[INFO] Running frei0r=kaleid0sc0pe:${KALEIDO_SIDES} on $(basename "$OUTPUT")..."
  run_or_echo ffmpeg -y -loglevel warning \
    -i "$OUTPUT" \
    -vf "format=rgba,frei0r=kaleid0sc0pe:${KALEIDO_SIDES},format=${PIX_FMT}" \
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
