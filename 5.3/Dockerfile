FROM        debian:squeeze
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Because the official image does not have the right repos
# From https://wiki.debian.org/fr/DebianSqueeze
RUN         echo "deb http://archive.debian.org/debian squeeze main" > /etc/apt/sources.list
RUN         echo "deb http://archive.debian.org/debian squeeze-lts main" >> /etc/apt/sources.list
RUN         echo "Acquire::Check-Valid-Until false;" >> /etc/apt/apt.conf

# DotDeb configuration and upgrade the system
RUN         apt-get update && \
            apt-get install --force-yes -y --no-install-recommends ca-certificates curl && \
            # Set the correct repo for PHP
            echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
            curl -sS http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
            # Clean
            apt-get purge ca-certificates curl -y && \
            apt-get autoremove -y && \
            apt-get clean && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Install PHP
RUN         apt-get update && \
            # Install all packages below :
            apt-get install --force-yes -y --no-install-recommends \
            # IPtables for stakkr
            iptables \
            # PHP Modules
            php5-apc \
            php5-cli \
            php5-curl \
            php5-ffmpeg \
            php5-fpm \
            php5-gd \
            php5-geoip \
            php5-imagick \
            php5-imap \
            php5-intl \
            php5-json \
            php5-ldap \
            php5-mcrypt \
            php5-memcached \
            php5-mysql \
            php5-odbc \
            php5-pgsql \
            php5-sqlite \
            php5-ssh2 \
            php5-tidy \
            php5-xhprof \
            php5-xdebug \
            php5-xsl && \
            # Clean and save space
            apt-get clean && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Install xhprof and mongo
RUN         apt-get update && \
            # Else I have an unmet dependency with php5-dev
            apt-get install --force-yes -y --no-install-recommends libc6=2.11.3-4 libc-bin=2.11.3-4 && \
            # Build tools (after the previous installation else it crashes)
            apt-get install --force-yes -y --no-install-recommends build-essential php-pear php5-dev && \
            # pear for mongo
            pecl channel-update pecl.php.net && \
            pecl install -f mongo && \
            rm -Rf /tmp/pear && \
            # Clean
            apt-get purge build-essential php-pear php5-dev -y && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*
            # Activate extension
            echo "extension=mongo.so" > /etc/php5/conf.d/mongo.ini

COPY        php-cli.ini    /etc/php5/cli/conf.d/zz-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/zz-custom-php.ini
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
