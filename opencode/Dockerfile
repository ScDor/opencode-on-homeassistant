# Use the pre-built image as a base
FROM ghcr.io/anomalyco/opencode:latest

# Revert to root to install jq and move files
USER root

# Install jq for config parsing
RUN apt-get update && apt-get install -y --no-install-recommends jq && rm -rf /var/lib/apt/lists/*

COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

# The base image likely uses 'opencode' user, but we stay root to start the server
# and allow HA to manage the process correctly.

CMD [ "/run.sh" ]
