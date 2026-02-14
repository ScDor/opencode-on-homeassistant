#!/bin/sh

echo "Starting OpenCode..."

PORT=$(sed -n 's/.*"port": *\([0-9]*\).*/\1/p' /data/options.json)
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)

export PORT="${PORT:-4096}"
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me}"

echo "Port: $PORT"
echo "Password set: ${PASSWORD:+yes}"

# Set HOME for opencode
export HOME="/data"
export XDG_DATA_HOME="/data/.local/share"
export XDG_CONFIG_HOME="/data/.config"

# Create data directories
mkdir -p /data/.local/share/opencode /data/.config/opencode

echo "Starting opencode web on 0.0.0.0:$PORT..."

exec opencode web --port "$PORT" --hostname 0.0.0.0
