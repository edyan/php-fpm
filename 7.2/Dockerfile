FROM        ubuntu:18.04
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends
# Upgrade the system + Install all packages
RUN         apt update && \
            apt upgrade -y && \
            # Packages
            apt install -y \
                ca-certificates \
                iptables \
                php7.2-bcmath \
                php7.2-bz2 \
                # php7.2-cgi \
                php7.2-cli \
                php7.2-curl \
                # php7.2-dba \
                # php7.2-dev \
                # php7.2-enchant \
                php7.2-fpm \
                php7.2-gd \
                # php7.2-gmp \
                php7.2-imap \
                # php7.2-interbase \
                php7.2-intl \
                php7.2-json \
                php7.2-ldap \
                php7.2-mbstring \
                php7.2-mysql \
                # php7.2-odbc \
                php7.2-opcache \
                php7.2-pgsql \
                # php7.2-phpdbg \
                # php7.2-pspell \
                php7.2-readline \
                # php7.2-recode \
                # php7.2-snmp \
                php7.2-soap \
                php7.2-sqlite3 \
                # php7.2-sybase \
                # php7.2-tidy \
                php7.2-xml \
                php7.2-xmlrpc \
                # php7.2-xsl
                php7.2-zip \
                php-apcu \
                php-geoip \
                php-imagick \
                php-memcache \
                php-memcached \
                php-mongodb \
                php-ssh2 \
                php-tideways \
                php-xdebug && \
            # Clean
            # Remove useless files installed for other PHP Versions
            rm -rf /usr/lib/php/20131226 /usr/lib/php/20151012 /usr/lib/php/20160303 /usr/lib/php/7.1 && \
            rm -rf /etc/php/5.6 /etc/php/7.0 /etc/php/7.1 && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -rf /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

COPY        php-cli.ini    /etc/php/7.2/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php/7.2/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php/7.2/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php/7.2/fpm/user-conf.d
RUN         echo "; Default empty file" > /etc/php/7.2/fpm/user-conf.d/example.conf
RUN         mkdir /var/log/php


# Create home for www-data
RUN         mkdir /home/www-data
RUN         chown www-data:www-data /home/www-data
RUN         usermod -d /home/www-data www-data
RUN         mkdir -p /run/php
RUN         chown www-data:www-data /run/php


COPY        run.sh     /run.sh
RUN         chmod +x    /run.sh

ENV         ENVIRONMENT dev
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
