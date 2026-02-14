#!/usr/bin/with-contenv bashio

bashio::log.info "Initializing OpenCode..."

# 1. Configuration
PASSWORD=$(bashio::config 'password')
REPO="opencode-dev/opencode"

# 2. Detect Architecture
ARCH=$(bashio::info.arch)
case $ARCH in
    "amd64") ASSET_MATCH="linux-x64" ;;
    "aarch64") ASSET_MATCH="linux-arm64" ;;
    *) bashio::log.error "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# 3. Update Check
bashio::log.info "Checking for updates..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | jq -r ".assets[] | select(.name | contains(\"$ASSET_MATCH\")) | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    bashio::log.error "Failed to fetch download URL"
    exit 1
fi

bashio::log.info "Downloading latest binary..."
curl -L -o /usr/bin/opencode "$DOWNLOAD_URL"
chmod +x /usr/bin/opencode

# 4. Launch
bashio::log.info "Launching server on port 4096..."
exec /usr/bin/opencode server --port 4096 --host 0.0.0.0 --token "$PASSWORD"
