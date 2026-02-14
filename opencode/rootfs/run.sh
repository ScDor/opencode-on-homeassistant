#!/bin/sh

echo "[INFO] Starting OpenCode Ingress Proxy..."

# 1. Read Options
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export PORT="${PORT:-4096}"

# 2. Start Nginx
nginx -c /etc/nginx/nginx.conf &

# 3. Launch OpenCode
echo "[INFO] Launching server on port $PORT..."
# OPENCODE_SERVER ensures the frontend connects to localhost instead of external HA domain
export OPENCODE_SERVER="http://127.0.0.1:$PORT"
exec opencode serve --port "$PORT" --hostname 127.0.0.1 --cors "*"
