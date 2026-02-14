FROM ghcr.io/anomalyco/opencode:latest

USER root

# Use /bin/sh because some minimal images don't include bash
COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

# Completely wipe entrypoint and use a basic shell to launch
ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
