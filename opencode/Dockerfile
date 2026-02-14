# Hardcode the base image to avoid ARG BUILD_FROM issues in local/custom builds
FROM ghcr.io/hassio-addons/debian-base:latest

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        jq \
        ca-certificates \
        git \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
