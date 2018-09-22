FROM        debian:jessie-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends
# Upgrade the system and Install PHP
RUN         apt-get update && \
            apt-get upgrade -y && \
            apt-get install -y \
                ca-certificates \
                iptables \
                # php5-adodb \
                php5-apcu \
                # php5-cgi \
                php5-cli \
                php5-curl \
                # php5-dbg \
                # php5-dev \
                # php5-enchant \
                php5-fpm \
                php5-gd \
                php5-geoip \
                # php5-geos \
                # php5-gmp \
                # php5-gnupg \
                php5-imagick \
                php5-imap \
                php5-interbase \
                php5-intl \
                php5-json \
                # php5-lasso \
                php5-ldap \
                php5-mcrypt \
                # php5-memcache \
                php5-memcached \
                php5-mongo \
                # php5-msgpack \
                # php5-mysql \
                php5-mysqlnd \
                # php5-mysqlnd-ms \
                # php5-oauth \
                php5-odbc \
                # php5-pecl-http \
                # php5-pecl-http-dev \
                php5-pgsql \
                # php5-phpdbg \
                # php5-pspell \
                # php5-radius \
                php5-readline \
                # php5-recode \
                php5-redis \
                # php5-remctl \
                # php5-rrd \
                # php5-sasl \
                # php5-snmp \
                php5-sqlite \
                php5-ssh2 \
                # php5-stomp \
                # php5-svn \
                # php5-sybase \
                # php5-tidy \
                # php5-uprofiler \
                # php5-xcache \
                php5-xdebug \
                php5-xhprof \
                php5-xmlrpc \
                php5-xsl \
                # To Build modules from pear
                build-essential php-pear php5-dev pkg-config libssl-dev && \
            # Build modules
            pecl channel-update pecl.php.net && \
            pecl install -f mongodb && \
            rm -Rf /tmp/pear && \
            # Enable module mongodb
            echo "extension=mongodb.so" > /etc/php5/mods-available/mongodb.ini && \
            php5enmod mongodb && \
            # Enable XhProf
            php5enmod xhprof && \
            # Because of a wrong comment in the official xhprof ini file
            echo "extension = xhprof.so" > /etc/php5/cli/conf.d/20-xhprof.ini && \
            # Clean
            apt-get purge build-essential php-pear php5-dev pkg-config libssl-dev -y && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -Rf /build /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*


COPY        php-cli.ini    /etc/php5/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php5/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php5/fpm/user-conf.d
RUN         echo "; Default empty file" > /etc/php5/fpm/user-conf.d/example.conf
RUN         mkdir /var/log/php


# Create home for www-data
RUN         mkdir /home/www-data
RUN         chown www-data:www-data /home/www-data
RUN         usermod -d /home/www-data www-data


COPY        run.sh     /run.sh
RUN         chmod +x    /run.sh

ENV         ENVIRONMENT dev
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
