FROM ghcr.io/anomalyco/opencode:latest

USER root

# Remove any existing run.sh if the base image has one that conflicts
RUN rm -f /run.sh

# Copy script to root filesystem
COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

# Force WORKDIR to / to ensure no relative path issues
WORKDIR /

# Completely override any entrypoint from the base image
ENTRYPOINT ["/bin/bash", "/run.sh"]
