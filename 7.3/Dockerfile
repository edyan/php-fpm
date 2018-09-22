FROM        debian:stretch-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends
# sury configuration + Upgrade the system + Install all packages
RUN         apt update && \
            # Install a few required packages
            apt install -y apt-transport-https gnupg ca-certificates curl && \
            # Setup sury repos
            echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/sury.org.list && \
            curl -sS https://packages.sury.org/php/apt.gpg | apt-key add - && \
            # Update, upgrade
            apt update -y && \
            apt upgrade -y && \
            # Packages
            apt install -y \
                iptables \
                php7.3-bcmath \
                php7.3-bz2 \
                # php7.3-cgi \
                php7.3-cli \
                php7.3-curl \
                # php7.3-dba \
                # php7.3-dev \
                # php7.3-enchant \
                php7.3-fpm \
                php7.3-gd \
                php7.3-gmp \
                php7.3-imap \
                php7.3-interbase \
                php7.3-intl \
                php7.3-json \
                php7.3-ldap \
                php7.3-mbstring \
                php7.3-mysql \
                # php7.3-odbc \
                php7.3-opcache \
                php7.3-pgsql \
                # php7.3-phpdbg \
                # php7.3-pspell \
                php7.3-readline \
                # php7.3-recode \
                # php7.3-snmp \
                php7.3-soap \
                php7.3-sqlite3 \
                # php7.3-sybase \
                # php7.3-tidy \
                php7.3-xml \
                php7.3-xmlrpc \
                php7.3-zip \
                # Not ready yet :
                # php-apcu \
                # php-geoip \
                # php-imagick \
                # php-memcache \
                # php-memcached \
                # php-mongodb \
                # php-ssh2 \
                # php-tideways \
                # php-xdebug && \
                && \
            # Clean
            # Remove useless files installed for other PHP Versions
            rm -rf /usr/lib/php/20131226 /usr/lib/php/20151012 /usr/lib/php/20160303 /usr/lib/php/20170718 && \
            rm -rf /etc/php/5.6 /etc/php/7.0 /etc/php/7.1 /etc/php/7.2 && \
            apt purge --autoremove -y curl gnupg && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

COPY        php-cli.ini    /etc/php/7.3/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php/7.3/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php/7.3/fpm/pool.d/

# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php/7.3/fpm/user-conf.d
RUN         echo "; Default empty file" > /etc/php/7.3/fpm/user-conf.d/example.conf
RUN         mkdir /var/log/php


# Create home for www-data
RUN         mkdir /home/www-data
RUN         chown www-data:www-data /home/www-data
RUN         usermod -d /home/www-data www-data
RUN         mkdir -p /run/php
RUN         chown www-data:www-data /run/php


COPY        run.sh     /run.sh
RUN         chmod +x   /run.sh

ENV         ENVIRONMENT dev
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
