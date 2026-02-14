#!/bin/sh

echo "[INFO] Starting OpenCode Ingress Proxy (v1.3.3)..."

# 1. Read Password
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"

# 2. Start Nginx
nginx -c /etc/nginx/nginx.conf &

# 3. Launch OpenCode
echo "[INFO] Launching server with CORS enabled..."
# Added --cors * to allow connections from the HA domain
exec opencode serve --port 4096 --hostname 127.0.0.1 --cors "*"
