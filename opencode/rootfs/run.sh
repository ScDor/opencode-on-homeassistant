#!/bin/bash

echo "[INFO] Initializing OpenCode..."

# 1. Configuration (Read from Home Assistant options file)
OPTIONS_FILE="/data/options.json"
if [ ! -f "$OPTIONS_FILE" ]; then
    echo "[ERROR] Configuration file $OPTIONS_FILE not found."
    exit 1
fi

PASSWORD=$(jq -r '.password // "change_me_immediately"' "$OPTIONS_FILE")
REPO="anomalyco/opencode"

# 2. Detect Architecture
ARCH_RAW=$(uname -m)
case $ARCH_RAW in
    "x86_64")
        ASSET_MATCH="linux-x64-baseline.tar.gz"
        ;;
    "aarch64")
        ASSET_MATCH="linux-arm64.tar.gz"
        ;;
    *)
        echo "[ERROR] Unsupported architecture: $ARCH_RAW"
        exit 1
        ;;
esac

echo "[INFO] Detected architecture: $ARCH_RAW"

# 3. Update Check
echo "[INFO] Checking for updates at $REPO..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

if ! echo "$LATEST_RELEASE" | jq -e '.assets' > /dev/null; then
    echo "[ERROR] Failed to fetch releases from GitHub. (Response: $(echo "$LATEST_RELEASE" | jq -r '.message // "Unknown error"'))"
    exit 1
fi

DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | jq -r ".assets[] | select(.name == \"opencode-$ASSET_MATCH\") | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    echo "[ERROR] Failed to find asset: opencode-$ASSET_MATCH"
    exit 1
fi

echo "[INFO] Downloading: $DOWNLOAD_URL"
curl -L -o /tmp/opencode.tar.gz "$DOWNLOAD_URL"
tar -xzf /tmp/opencode.tar.gz -C /usr/bin/
chmod +x /usr/bin/opencode
rm /tmp/opencode.tar.gz

# 4. Environment Setup (Optional for HA Context)
export HOMEASSISTANT_URL="http://supervisor/core"

# 5. Launch
echo "[INFO] Launching OpenCode server on port 4096..."
exec /usr/bin/opencode server --port 4096 --host 0.0.0.0 --token "$PASSWORD"
