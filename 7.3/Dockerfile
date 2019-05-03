FROM        debian:buster-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Install a few required packages
            apt update -y && \
            apt-get upgrade -y && \
            apt-get install -y \
                ca-certificates \
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
                # php7.3-gmp \
                php7.3-imap \
                # php7.3-interbase \
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
                php7.3-tidy \
                php7.3-xml \
                php7.3-xmlrpc \
                php7.3-xsl \
                php7.3-zip \
                php-apcu \
                php-geoip \
                php-imagick \
                php-memcache \
                php-memcached \
                php-mongodb \
                php-redis \
                php-ssh2 \
                php-tideways \
                php-xdebug && \
            # Clean
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /usr/lib/php/20170718 /etc/php/7.2 && \
            rm -rf /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*


COPY        php-cli.ini    /etc/php/7.3/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php/7.3/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php/7.3/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php/7.3/fpm/user-conf.d && \
            echo "; Default empty file" > /etc/php/7.3/fpm/user-conf.d/example.conf && \
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

