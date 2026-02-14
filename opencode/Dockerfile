FROM ghcr.io/anomalyco/opencode:latest

USER root

# Install Nginx using apk (since the base image is Alpine)
RUN apk add --no-cache nginx

# Copy Nginx config and startup script
COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
