FROM ghcr.io/anomalyco/opencode:latest

USER root

RUN apk add --no-cache nginx

COPY rootfs/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
