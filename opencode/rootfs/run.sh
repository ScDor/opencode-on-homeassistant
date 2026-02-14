#!/usr/bin/with-contenv bashio

bashio::log.info "Initializing OpenCode..."

# 1. Configuration
PASSWORD=$(bashio::config 'password')
REPO="anomalyco/opencode"

# 2. Detect Architecture
ARCH=$(bashio::info.arch)
case $ARCH in
    "amd64") ASSET_MATCH="linux-x64-baseline.tar.gz" ;;
    "aarch64") ASSET_MATCH="linux-arm64.tar.gz" ;;
    *) bashio::log.error "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# 3. Update Check
bashio::log.info "Checking for updates at $REPO..."
LATEST_RELEASE=$(curl -s "https://api.github.com/repos/$REPO/releases/latest")

# Check if we got a valid response
if ! echo "$LATEST_RELEASE" | jq -e '.assets' > /dev/null; then
    bashio::log.error "Failed to fetch releases from GitHub."
    exit 1
fi

# Pick the standard binary (not musl) for Debian compatibility
DOWNLOAD_URL=$(echo "$LATEST_RELEASE" | jq -r ".assets[] | select(.name == \"opencode-$ASSET_MATCH\") | .browser_download_url")

if [ -z "$DOWNLOAD_URL" ] || [ "$DOWNLOAD_URL" == "null" ]; then
    bashio::log.error "Failed to find asset: opencode-$ASSET_MATCH"
    exit 1
fi

bashio::log.info "Downloading: $DOWNLOAD_URL"
curl -L -o /tmp/opencode.tar.gz "$DOWNLOAD_URL"
tar -xzf /tmp/opencode.tar.gz -C /usr/bin/
chmod +x /usr/bin/opencode
rm /tmp/opencode.tar.gz

# 4. Launch
bashio::log.info "Launching server..."
exec /usr/bin/opencode server --port 4096 --host 0.0.0.0 --token "$PASSWORD"
