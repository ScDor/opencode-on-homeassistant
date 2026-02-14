#!/bin/sh

echo "[INFO] Starting OpenCode (Version 1.2.8)..."

# 1. Read Password from HA options
# Using a slightly more robust sed pattern
PASSWORD=$(sed -n 's/.*"password": *"\([^"]*\)".*/\1/p' /data/options.json)
PASSWORD_FINAL="${PASSWORD:-change_me_immediately}"

# 2. Export environment variables (OpenCode ONLY supports these for auth)
export OPENCODE_SERVER_PASSWORD="$PASSWORD_FINAL"
export OPENCODE_SERVER_USERNAME="opencode"

# 3. Launch
echo "[INFO] Launching headless server on port 4096..."
# Using 'serve' instead of 'web' for headless Docker environments
# Removed non-existent flags --username and --password
exec opencode serve --port 4096 --hostname 0.0.0.0
