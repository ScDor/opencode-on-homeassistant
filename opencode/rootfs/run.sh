#!/usr/bin/with-contenv bashio

bashio::log.info "Initializing OpenCode..."

# 1. Configuration
PASSWORD=$(bashio::config 'password')
REPO="anomalyco/opencode"

# 2. Detect Architecture
ARCH=$(bashio::info.arch)
case $ARCH in
    "amd64") ASSET_MATCH="linux-x64-baseline" ;;
    "aarch64") ASSET_MATCH="linux-arm64" ;;
    *) bashio::log.error "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# 3. Update Check
bashio::log.info "Checking for updates at $REPO..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Check if we got a valid response (not rate limited or 404)
if ! echo "$LATEST_RELEASE" | jq -e '.assets' > /dev/null; then
    bashio::log.error "Failed to fetch releases from GitHub. (Response: $(echo "$LATEST_RELEASE" | jq -r '.message // "Unknown error"'))"
    exit 1
fi

DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | jq -r ".assets[] | select(.name | contains(\"$ASSET_MATCH\")) | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    bashio::log.error "Failed to find a download URL for $ASSET_MATCH in the latest release."
    exit 1
fi

bashio::log.info "Downloading latest binary from $DOWNLOAD_URL..."
curl -L -o /tmp/opencode.tar.gz "$DOWNLOAD_URL"
tar -xzf /tmp/opencode.tar.gz -C /usr/bin/
chmod +x /usr/bin/opencode
rm /tmp/opencode.tar.gz

# 4. Launch
bashio::log.info "Launching server on port 4096..."
exec /usr/bin/opencode server --port 4096 --host 0.0.0.0 --token "$PASSWORD"
