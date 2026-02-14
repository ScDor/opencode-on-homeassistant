# Use the pre-built image as a base
FROM ghcr.io/anomalyco/opencode:latest

# Revert to root to configure the container
USER root

# Copy our wrapper script
COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
