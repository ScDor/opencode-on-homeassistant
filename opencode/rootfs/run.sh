#!/bin/bash

echo "[INFO] Starting OpenCode from pre-built image..."

# 1. Read Password
OPTIONS_FILE="/data/options.json"
PASSWORD=$(jq -r '.password // "change_me_immediately"' "$OPTIONS_FILE")

# 2. Export environment variables for the OpenCode binary
export OPENCODE_SERVER_PASSWORD="$PASSWORD"
export OPENCODE_SERVER_USERNAME="opencode"

# 3. Launch
echo "[INFO] Launching server on port 4096..."
# Note: Using the binary that is already in the base image's PATH
exec opencode server --port 4096 --host 0.0.0.0
