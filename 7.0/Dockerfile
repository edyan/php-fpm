FROM        debian:stretch-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

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
                php-mongodb \
                php-redis \
                php-ssh2 \
                php-tideways && \
            # Clean
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*


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
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
