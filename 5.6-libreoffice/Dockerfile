FROM        edyan/php:5.6-git
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

RUN         echo "deb http://http.debian.net/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list.d/jessie-backports.list

# To avoid error installing Java
RUN         mkdir /usr/share/man/man1

# Upgrade the system and Install GIT and Libreoffice
RUN         apt-get update && \
            apt-get upgrade -y && \
            apt-get install -t jessie-backports -y --no-install-recommends \
                default-jre-headless libreoffice-writer && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*
