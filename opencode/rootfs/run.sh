#!/bin/sh

echo "[INFO] Starting OpenCode Ingress Proxy..."

# 1. Read Options
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export PORT="${PORT:-4096}"

echo "[INFO] Password: $OPENCODE_SERVER_PASSWORD"
echo "[INFO] Port: $PORT"

# 2. Start Nginx
nginx -c /etc/nginx/nginx.conf &

# 3. Launch OpenCode
echo "[INFO] Launching opencode web on port $PORT..."

exec opencode web --port "$PORT" --hostname 0.0.0.0 --cors "*"
