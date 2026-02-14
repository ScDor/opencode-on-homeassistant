FROM ghcr.io/anomalyco/opencode:latest

USER root

# Move the script to a path that won't be confused with a directory
COPY rootfs/run.sh /usr/bin/opencode-start
RUN chmod a+x /usr/bin/opencode-start

# Setting WORKDIR to / prevents the binary from trying to 'cd' into the script path
WORKDIR /

ENTRYPOINT []
CMD [ "/usr/bin/opencode-start" ]
