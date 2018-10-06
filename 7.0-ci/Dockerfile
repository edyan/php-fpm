FROM        edyan/php:7.0
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Install new package
RUN         apt update && \
            apt upgrade -y && \
            # Install a few required packages
            apt install -y curl git openssh-client unzip && \
            # Install composer
            curl https://getcomposer.org/composer.phar --output /usr/local/bin/composer && \
            chmod +x /usr/local/bin/composer && \
            # Upgrade composer
            /usr/local/bin/composer self-update && \
            # Clean
            apt purge --autoremove -y curl && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

RUN         mkdir /var/log/php
