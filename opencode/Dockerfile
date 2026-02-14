# Use the pre-built image as a base to ensure all libraries are present
FROM ghcr.io/anomalyco/opencode:latest

# We need jq to read the password from HA options
USER root
RUN apt-get update && apt-get install -y jq && rm -rf /var/lib/apt/lists/*

COPY rootfs/run.sh /run.sh
RUN chmod a+x /run.sh

# Revert to the expected user if the base image uses one
# USER opencode 

CMD [ "/run.sh" ]
