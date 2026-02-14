#!/bin/sh

echo "[INFO] Starting OpenCode (Zero-Install Wrapper)..."

# 1. Read Password from HA options using standard shell tools (no jq required)
# Grabs the value between "password": " and the next "
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)

# 2. Export environment variables for the OpenCode binary
export OPENCODE_SERVER_PASSWORD="${PASSWORD:-change_me_immediately}"
export OPENCODE_SERVER_USERNAME="opencode"

# 3. Launch
echo "[INFO] Launching server on port 4096..."
exec opencode server --port 4096 --host 0.0.0.0
