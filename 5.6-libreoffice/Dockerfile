FROM inetprocess/php:5.6-git
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

RUN echo "deb http://http.debian.net/debian jessie-backports main contrib non-free" >> /etc/apt/sources.list.d/jessie-backports.list

# Upgrade the system and Install GIT and Libreoffice
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -t jessie-backports -y --no-install-recommends libreoffice-writer openjdk-8-jre && \

    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*
