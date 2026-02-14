#!/bin/sh

echo "[INFO] Starting OpenCode (Version 1.2.7)..."

# 1. Read Password from HA options
# Enhanced regex to be more robust
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PASSWORD_FINAL="${PASSWORD:-change_me_immediately}"

# 2. Export environment variables (as fallback)
export OPENCODE_SERVER_PASSWORD="$PASSWORD_FINAL"
export OPENCODE_SERVER_USERNAME="opencode"

# 3. Launch
echo "[INFO] Launching server on port 4096..."
# Using both flags and env vars to ensure the auth 'sticks'
exec opencode web --port 4096 --hostname 0.0.0.0 --username opencode --password "$PASSWORD_FINAL"
