FROM        debian:stretch-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Install a few required packages
            apt update -y && \
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
                php7.1-bcmath \
                php7.1-bz2 \
                # php7.1-cgi \
                php7.1-cli \
                # php7.1-common \
                php7.1-curl \
                # php7.1-dba \
                # php7.1-dev \
                # php7.1-enchant \
                php7.1-fpm \
                php7.1-gd \
                php7.1-gmp \
                php7.1-imap \
                php7.1-interbase \
                php7.1-intl \
                php7.1-json \
                php7.1-ldap \
                php7.1-mbstring \
                php7.1-mcrypt \
                php7.1-mysql \
                php7.1-odbc \
                php7.1-opcache \
                php7.1-pgsql \
                # php7.1-phpdbg \
                # php7.1-pspell \
                php7.1-readline \
                # php7.1-recode \
                # php7.1-snmp \
                php7.1-soap \
                php7.1-sqlite3 \
                # php7.1-sybase \
                # php7.1-tidy \
                php7.1-xml \
                php7.1-xmlrpc \
                php7.1-zip \
                php-apcu \
                php-geoip \
                php-imagick \
                php-memcached \
                php-mongodb \
                php-redis \
                php-ssh2 \
                php-tideways \
                php-xdebug && \
            # Clean
            # Remove useless files installed for other PHP Versions
            rm -rf /usr/lib/php/20131226 /usr/lib/php/20151012 /usr/lib/php/20170718 /usr/lib/php/20180731 && \
            rm -rf /etc/php/5.6 /etc/php/7.0 /etc/php/7.2 /etc/php/7.3 && \
            apt purge --autoremove -y curl gnupg && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -rf /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

COPY        php-cli.ini    /etc/php/7.1/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php/7.1/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php/7.1/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php/7.1/fpm/user-conf.d && \
            echo "; Default empty file" > /etc/php/7.1/fpm/user-conf.d/example.conf && \
# Global Logs
            mkdir /var/log/php && \
# Create home for www-data
            mkdir /home/www-data && \
            chown www-data:www-data /home/www-data && \
            usermod -d /home/www-data www-data && \
            mkdir -p /run/php && \
            chown www-data:www-data /run/php

COPY        run.sh     /run.sh
RUN         chmod +x   /run.sh

ENV         ENVIRONMENT dev
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
