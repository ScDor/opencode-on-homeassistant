ARG BUILD_FROM
FROM $BUILD_FROM

# Use Debian base for better binary compatibility
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        jq \
        ca-certificates \
        git \
        libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
