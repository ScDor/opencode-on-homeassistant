FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    ca-certificates \
    git \
    tar \
    libstdc++6 \
    && rm -rf /var/lib/apt/lists/*

COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
