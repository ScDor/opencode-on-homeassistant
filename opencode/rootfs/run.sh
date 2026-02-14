#!/bin/sh

echo "Starting OpenCode..."

PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me}"

echo "Password set: ${PASSWORD:+yes}"

export HOME="/data"
export XDG_DATA_HOME="/data/.local/share"
export XDG_CONFIG_HOME="/data/.config"

mkdir -p /data/.local/share/opencode /data/.config/opencode

echo "Starting opencode web on 0.0.0.0:4096..."

exec opencode web --port 4096 --hostname 0.0.0.0
