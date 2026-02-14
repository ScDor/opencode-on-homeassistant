ARG BUILD_FROM
FROM $BUILD_FROM

# Install dependencies
RUN apk add --no-cache \
    curl \
    jq \
    git \
    gcompat \
    ca-certificates \
    libstdc++ \
    libgcc

# Copy root filesystem
COPY rootfs /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
