FROM ghcr.io/anomalyco/opencode:latest

USER root

# Install Nginx for path rewriting
RUN apt-get update && apt-get install -y --no-install-recommends nginx && rm -rf /var/lib/apt/lists/*

# Copy Nginx config and startup script
COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
