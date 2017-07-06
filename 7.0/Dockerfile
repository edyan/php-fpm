FROM debian:stretch
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

# Upgrade the system and Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
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
    php7.0-sqlite3 \
    php7.0-tidy \
    php7.0-xdebug \
    php7.0-xsl \
    php7.0-zip \
    php-apcu \
    php-geoip \
    php-imagick \
    php-mongodb \
    php-ssh2 \
    php-tideways && \
    
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

COPY php-cli.ini    /etc/php/7.0/cli/conf.d/30-custom-php.ini
COPY php-fpm.ini    /etc/php/7.0/fpm/conf.d/30-custom-php.ini
COPY www.conf       /etc/php/7.0/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN mkdir /etc/php/7.0/fpm/user-conf.d
RUN echo "; Default empty file" > /etc/php/7.0/fpm/user-conf.d/example.conf
RUN mkdir /var/log/php


# Create home for www-data
RUN mkdir /home/www-data
RUN chown www-data:www-data /home/www-data
RUN usermod -d /home/www-data www-data
RUN mkdir -p /run/php
RUN chown www-data:www-data /run/php


COPY run.sh     /run.sh
RUN  chmod +x    /run.sh

ENV ENVIRONMENT dev
ENV FPM_UID 33
ENV FPM_GID 33

EXPOSE 9000

CMD ["/run.sh"]
