FROM debian:stretch-slim
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

# DotDeb configuration + Upgrade the system
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-transport-https \
    gnupg \
    ca-certificates \
    curl && \

    echo "deb https://packages.sury.org/php/ stretch main" >> /etc/apt/sources.list.d/sury.org.list && \
    curl -sS https://packages.sury.org/php/apt.gpg | apt-key add - && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get purge curl -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Upgrade the system and Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \

    iptables \

    php7.1-bz2 \
    php7.1-cli \
    php7.1-curl \
    php7.1-fpm \
    php7.1-gd \
    php7.1-imap \
    php7.1-intl \
    php7.1-json \
    php7.1-ldap \
    php7.1-mbstring \
    php7.1-mcrypt \
    php7.1-mysql \
    php7.1-opcache \
    php7.1-odbc \
    php7.1-pgsql \
    php7.1-sqlite3 \
    php7.1-tidy \
    php7.1-xdebug \
    php7.1-xsl \
    php7.1-zip \
    php-apcu \
    php-bcmath \
    php-geoip \
    php-imagick \
    php-mongodb \
    php-ssh2 \
    php-tideways && \

    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*

COPY php-cli.ini    /etc/php/7.1/cli/conf.d/30-custom-php.ini
COPY php-fpm.ini    /etc/php/7.1/fpm/conf.d/30-custom-php.ini
COPY www.conf       /etc/php/7.1/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN mkdir /etc/php/7.1/fpm/user-conf.d
RUN echo "; Default empty file" > /etc/php/7.1/fpm/user-conf.d/example.conf
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
