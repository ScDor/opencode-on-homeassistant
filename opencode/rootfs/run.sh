#!/bin/sh

echo "[INFO] Starting OpenCode Ingress Proxy Setup..."

# 1. Read Password
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"

# 2. Start Nginx in background
nginx -c /etc/nginx/nginx.conf &

# 3. Launch OpenCode on local loopback only
echo "[INFO] Launching OpenCode server (Internal)..."
exec opencode serve --port 4096 --hostname 127.0.0.1
