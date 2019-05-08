FROM        debian:wheezy-slim

ARG         BUILD_DATE
ARG         DEBIAN_FRONTEND=noninteractive

LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>"
LABEL       org.label-schema.build-date=$BUILD_DATE

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Set right repos
            echo "deb http://archive.debian.org/debian wheezy main contrib" > /etc/apt/sources.list && \
            echo "deb http://archive.debian.org/debian wheezy-backports main contrib" >> /etc/apt/sources.list && \
            # Upgrade the system + Install all packages
            apt-get update && \
            apt-get upgrade -y && \
            # Because else it doesn't work ;)
            apt-get install --reinstall -y --force-yes perl-base=5.14.2-21+deb7u3 libc6=2.13-38+deb7u10 libc-bin=2.13-38+deb7u10 && \
            apt-get install -y \
                iptables \
                # All PHP Packages
                php-apc \
                php5-cli \
                php5-curl \
                # php5-ffmpeg \
                php5-fpm \
                php5-gd \
                php5-geoip \
                php5-imagick \
                php5-imap \
                php5-intl \
                php5-json \
                php5-ldap \
                php5-mcrypt \
                php5-memcache \
                php5-memcached \
                php5-mysql \
                php5-odbc \
                php5-pgsql \
                php5-sqlite \
                php5-tidy \
                php5-xdebug \
                php5-xsl && \
            # Now Build
            apt-get install -y \
                build-essential php-pear php5-dev libcurl4-openssl-dev pkg-config && \
            pecl channel-update pecl.php.net && \
            pecl install xhprof-beta mongo && \
            echo "extension=xhprof.so" > /etc/php5/mods-available/xhprof.ini && \
            php5enmod xhprof && \
            echo "extension=mongo.so" > /etc/php5/mods-available/mongo.ini && \
            php5enmod mongo && \
            apt-get purge -y build-essential php-pear php5-dev libcurl4-openssl-dev pkg-config && \
            # Clean
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /build /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests

COPY        php-cli.ini    /etc/php5/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php5/fpm/pool.d/

# For custom Configuration that comes from outside (via a docker compose mount)
RUN         mkdir /etc/php5/fpm/user-conf.d && \
            echo "; Default empty file" > /etc/php5/fpm/user-conf.d/example.conf && \
            # Global Logs
            mkdir /var/log/php && \
            # Create home for www-data
            mkdir /home/www-data && \
            chown www-data:www-data /home/www-data && \
            usermod -d /home/www-data www-data

COPY        run.sh     /run.sh
RUN         chmod +x    /run.sh

ENV         ENVIRONMENT dev
ENV         FPM_UID 33
ENV         FPM_GID 33

EXPOSE      9000

CMD         ["/run.sh"]
