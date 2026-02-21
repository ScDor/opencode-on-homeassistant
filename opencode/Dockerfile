FROM ghcr.io/anomalyco/opencode:beta

# Install bash for terminal support
RUN apk add --no-cache bash

COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENV SHELL=/bin/bash

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
