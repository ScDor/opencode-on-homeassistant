ARG BUILD_FROM
FROM $BUILD_FROM

RUN apk add --no-cache \
    curl \
    jq \
    git \
    gcompat \
    ca-certificates

COPY rootfs /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
