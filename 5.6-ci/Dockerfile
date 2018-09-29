FROM        edyan/php:5.6
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Install new package
RUN         apt-get update && \
            apt-get upgrade -y && \
            # Install a few required packages
            apt-get install -y curl git openssh-client unzip && \
            # Install composer
            curl https://getcomposer.org/download/1.7.2/composer.phar --output /usr/local/bin/composer && \
            chmod +x /usr/local/bin/composer && \
            # Upgrade composer
            /usr/local/bin/composer self-update && \
            # Clean
            apt-get purge -y curl && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

RUN         mkdir /var/log/php
