FROM        edyan/php:5.6
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Upgrade the system and Install GIT
RUN         apt-get update && \
            apt-get upgrade -y && \
            apt-get install -y --no-install-recommends git openssh-client && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*
