FROM        debian:stretch-slim

ARG         DEBIAN_FRONTEND=noninteractive
ARG         BUILD_DATE
ARG         DOCKER_TAG
ARG         VCS_REF

LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>" \
            org.label-schema.build-date=$BUILD_DATE \
            org.label-schema.name=$DOCKER_TAG \
            org.label-schema.description="Docker PHP Image based on Debian and including main modules" \
            org.label-schema.url="https://cloud.docker.com/u/edyan/repository/docker/edyan/php" \
            org.label-schema.vcs-url="https://github.com/edyan/docker-php" \
            org.label-schema.vcs-ref=$VCS_REF \
            org.label-schema.schema-version="1.0" \
            org.label-schema.vendor="edyan" \
            org.label-schema.version=$VERSION \
            org.label-schema.docker.cmd="docker run -d --rm $DOCKER_TAG"

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Upgrade the system and Install PHP
            apt-get update && \
            apt-get upgrade -y && \
            apt-get install -y \
                ca-certificates \
                iptables \
                php7.0-bz2 \
                php7.0-cli \
                php7.0-curl \
                php7.0-fpm \
                php7.0-gd \
                php7.0-imap \
                php7.0-intl \
                php7.0-json \
                php7.0-ldap \
                php7.0-mbstring \
                php7.0-mcrypt \
                php7.0-mysql \
                php7.0-opcache \
                php7.0-odbc \
                # php7.0-phpdbg \
                php7.0-pgsql \
                php7.0-readline \
                php7.0-soap \
                php7.0-sqlite3 \
                php7.0-tidy \
                php7.0-xdebug \
                php7.0-xsl \
                php7.0-zip \
                php-apcu \
                php-bcmath \
                php-geoip \
                php-imagick \
                php-ssh2 \
                php-tideways && \
            # Install a few extensions with PECL instead of distro ones
            apt install -y build-essential libmemcached11 libmemcachedutil2 libmemcached-dev php-pear php7.0-dev pkg-config zlib1g-dev && \
            pecl channel-update pecl.php.net && \
            pecl install memcached mongodb redis && \
            # Activate it
            echo "extension=mongodb.so" > /etc/php/7.0/mods-available/mongodb.ini && \
            phpenmod mongodb && \
            echo "extension=memcached.so" > /etc/php/7.0/mods-available/memcached.ini && \
            phpenmod memcached && \
            echo "extension=redis.so" > /etc/php/7.0/mods-available/redis.ini && \
            phpenmod redis && \
            apt purge --autoremove -y build-essential libmemcached-dev php-pear php7.0-dev pkg-config zlib1g-dev && \
            # Clean
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            # Empty some directories from all files and hidden files
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /build /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests


COPY        php-cli.ini    /etc/php/7.0/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php/7.0/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php/7.0/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php/7.0/fpm/user-conf.d && \
            echo "; Default empty file" > /etc/php/7.0/fpm/user-conf.d/example.conf && \
            # Global Logs
            mkdir /var/log/php && \
            # Create home for www-data
            mkdir /home/www-data && \
            chown www-data:www-data /home/www-data && \
            usermod -d /home/www-data www-data && \
            mkdir -p /run/php && \
            chown www-data:www-data /run/php

COPY        run.sh     /run.sh
RUN         chmod +x    /run.sh

ENV         ENVIRONMENT dev
ENV         PHP_ENABLED_MODULES ""
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
