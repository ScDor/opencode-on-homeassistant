FROM ghcr.io/anomalyco/opencode:beta

# Install dependencies for terminal/PTY support
# - bash: shell for terminal
# - python3: needed for building native modules
# - make, g++, pkgconf: needed for compiling node-pty
# - linux-headers: needed for PTY compilation
RUN apk add --no-cache bash python3 make g++ pkgconf linux-headers

COPY rootfs/run.sh /run-opencode.sh
RUN chmod a+x /run-opencode.sh

ENV SHELL=/bin/bash

ENTRYPOINT ["/bin/sh", "/run-opencode.sh"]
