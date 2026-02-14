FROM ghcr.io/anomalyco/opencode:latest

COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
