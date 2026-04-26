#!/usr/bin/env bash
# deploy.sh — Production deployment for Debian 12 (bookworm)
# Target: kaleido.onojk123.com  •  IP: 35.202.121.22
# User:   onojk123_gmail_com
#
# Usage (run as root or via sudo on the VM):
#   bash scripts/deploy.sh          # full first-time install
#   bash scripts/deploy.sh --update # pull latest code and restart service

set -euo pipefail

# ── Config ────────────────────────────────────────────────────────────────────
APP_USER="onojk123_gmail_com"
APP_HOME="/home/${APP_USER}"
APP_DIR="${APP_HOME}/kaleido-video-generator"
REPO_URL="https://github.com/onojk/kaleido-video-generator.git"
VENV="${APP_DIR}/.venv"
DOMAIN="kaleido.onojk123.com"
GUNICORN_PORT="8000"
SERVICE_NAME="kaleido"
NGINX_CONF="/etc/nginx/sites-available/${SERVICE_NAME}"

UPDATE_ONLY=0
[[ "${1:-}" = "--update" ]] && UPDATE_ONLY=1

# ── Helpers ───────────────────────────────────────────────────────────────────
info()  { echo "[INFO]  $*"; }
ok()    { echo "[OK]    $*"; }
die()   { echo "[ERROR] $*" >&2; exit 1; }

require_root() {
  [[ "$(id -u)" -eq 0 ]] || die "Run this script as root (sudo bash scripts/deploy.sh)"
}

# ── Update path (pull + restart only) ────────────────────────────────────────
if [[ "$UPDATE_ONLY" -eq 1 ]]; then
  info "Update mode — pulling latest code..."
  sudo -u "$APP_USER" git -C "$APP_DIR" pull --ff-only
  sudo -u "$APP_USER" "${VENV}/bin/pip" install -q -r "${APP_DIR}/requirements.txt"
  systemctl restart "${SERVICE_NAME}"
  ok "Service restarted. Done."
  exit 0
fi

require_root

# ── 1. System packages ────────────────────────────────────────────────────────
info "Installing system packages..."
apt-get update -qq
apt-get install -y --no-install-recommends \
  git \
  python3 python3-venv python3-pip \
  ffmpeg \
  imagemagick \
  frei0r-plugins \
  parallel \
  nginx \
  certbot python3-certbot-nginx \
  curl \
  psutil 2>/dev/null || true
ok "System packages installed"

# Ensure user exists
if ! id "$APP_USER" &>/dev/null; then
  info "Creating system user ${APP_USER}..."
  useradd --system --create-home --shell /bin/bash "$APP_USER"
fi

# ── 2. Clone or update repo ───────────────────────────────────────────────────
if [[ -d "${APP_DIR}/.git" ]]; then
  info "Repo already present — pulling latest..."
  sudo -u "$APP_USER" git -C "$APP_DIR" pull --ff-only
else
  info "Cloning repository..."
  sudo -u "$APP_USER" git clone "$REPO_URL" "$APP_DIR"
fi
ok "Code at ${APP_DIR}"

# ── 3. Python virtual environment ─────────────────────────────────────────────
info "Setting up Python venv..."
sudo -u "$APP_USER" python3 -m venv "$VENV"
sudo -u "$APP_USER" "${VENV}/bin/pip" install -q --upgrade pip
sudo -u "$APP_USER" "${VENV}/bin/pip" install -q -r "${APP_DIR}/requirements.txt"
ok "Venv ready at ${VENV}"

# ── 4. Jobs and logs directories ─────────────────────────────────────────────
info "Creating runtime directories..."
sudo -u "$APP_USER" mkdir -p "${APP_DIR}/jobs" "${APP_DIR}/logs"
ok "Runtime dirs ready"

# ── 5. Systemd service ────────────────────────────────────────────────────────
info "Installing systemd service (${SERVICE_NAME}.service)..."
cat > "/etc/systemd/system/${SERVICE_NAME}.service" << EOF
[Unit]
Description=Kaleidoscope Video Generator (Gunicorn)
After=network.target

[Service]
Type=simple
User=${APP_USER}
Group=${APP_USER}
WorkingDirectory=${APP_DIR}/src
Environment="PATH=${VENV}/bin:/usr/local/bin:/usr/bin:/bin"
Environment="PORT=${GUNICORN_PORT}"
ExecStart=${VENV}/bin/gunicorn app:app \\
    --bind 127.0.0.1:${GUNICORN_PORT} \\
    --workers 1 \\
    --timeout 600 \\
    --log-level info \\
    --access-logfile ${APP_DIR}/logs/access.log \\
    --error-logfile  ${APP_DIR}/logs/error.log
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable "${SERVICE_NAME}"
systemctl restart "${SERVICE_NAME}"
ok "Service running (127.0.0.1:${GUNICORN_PORT})"

# ── 6. Nginx reverse proxy ────────────────────────────────────────────────────
info "Writing Nginx config for ${DOMAIN}..."
cat > "$NGINX_CONF" << EOF
server {
    listen 80;
    server_name ${DOMAIN};

    # Large uploads / long-running proxy pass
    client_max_body_size 64M;
    proxy_read_timeout   620s;
    proxy_send_timeout   620s;

    location / {
        proxy_pass         http://127.0.0.1:${GUNICORN_PORT};
        proxy_set_header   Host              \$host;
        proxy_set_header   X-Real-IP         \$remote_addr;
        proxy_set_header   X-Forwarded-For   \$proxy_add_x_forwarded_for;
        proxy_set_header   X-Forwarded-Proto \$scheme;
        # Allow SSE / long-poll log streaming
        proxy_buffering    off;
    }

    # Serve static files directly
    location /static/ {
        alias ${APP_DIR}/static/;
        expires 7d;
        access_log off;
    }

    # Video downloads — allow large file transfer
    location /download/ {
        proxy_pass         http://127.0.0.1:${GUNICORN_PORT};
        proxy_set_header   Host              \$host;
        proxy_buffering    on;
        proxy_buffer_size  16k;
        proxy_buffers      64 16k;
    }
}
EOF

ln -sf "$NGINX_CONF" "/etc/nginx/sites-enabled/${SERVICE_NAME}" 2>/dev/null || true
rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

nginx -t
systemctl reload nginx
ok "Nginx configured for http://${DOMAIN}"

# ── 7. TLS with Let's Encrypt ─────────────────────────────────────────────────
info "Requesting Let's Encrypt certificate for ${DOMAIN}..."
certbot --nginx \
  --non-interactive \
  --agree-tos \
  --redirect \
  --email "onojk123@gmail.com" \
  -d "$DOMAIN" \
  || echo "[WARN] certbot failed — site is running on HTTP. Re-run manually: certbot --nginx -d ${DOMAIN}"

# certbot installs a cron/systemd timer for auto-renewal automatically on Debian 12

# ── 8. ImageMagick policy (allow large image ops) ────────────────────────────
info "Patching ImageMagick security policy for large images..."
POLICY="/etc/ImageMagick-6/policy.xml"
if [[ -f "$POLICY" ]]; then
  # Raise memory and disk limits; re-enable PS/PDF reads if restricted
  sed -i \
    -e 's|<policy domain="resource" name="memory" value="[^"]*"/>|<policy domain="resource" name="memory" value="2GiB"/>|' \
    -e 's|<policy domain="resource" name="disk" value="[^"]*"/>|<policy domain="resource" name="disk" value="8GiB"/>|' \
    -e 's|<policy domain="resource" name="width" value="[^"]*"/>|<policy domain="resource" name="width" value="32KP"/>|' \
    -e 's|<policy domain="resource" name="height" value="[^"]*"/>|<policy domain="resource" name="height" value="32KP"/>|' \
    "$POLICY"
  ok "ImageMagick policy patched"
else
  echo "[WARN] ImageMagick policy.xml not found — skipping"
fi

# ── 9. Firewall (ufw) — only if active ───────────────────────────────────────
if command -v ufw &>/dev/null && ufw status | grep -q "Status: active"; then
  info "Opening ports 80 and 443 in ufw..."
  ufw allow 80/tcp
  ufw allow 443/tcp
  ok "Firewall updated"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "═══════════════════════════════════════════════════"
echo " Kaleidoscope Video Generator — deployed"
echo "   URL:     https://${DOMAIN}"
echo "   Service: systemctl status ${SERVICE_NAME}"
echo "   Logs:    ${APP_DIR}/logs/"
echo "   Update:  sudo bash scripts/deploy.sh --update"
echo "═══════════════════════════════════════════════════"
