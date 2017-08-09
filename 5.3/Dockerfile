FROM debian:squeeze
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

# Because the official image does not have the right repos
RUN echo "deb http://archive.debian.org/debian/ squeeze main contrib non-free" > /etc/apt/sources.list

# DotDeb configuration and upgrade the system
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl && \

    echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    curl -sS http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get purge ca-certificates curl -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \

    iptables \

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

    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Install xhprof and mongo
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    # Else I have an unmet dependency with php5-dev
    DEBIAN_FRONTEND=noninteractive apt-get install libc6=2.11.3-4 libc-bin=2.11.3-4 --force-yes -y --no-install-recommends && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends build-essential php-pear php5-dev && \

    pecl channel-update pecl.php.net && \
    pecl install -f mongo && \
    rm -Rf /tmp/pear && \

    DEBIAN_FRONTEND=noninteractive apt-get purge build-essential php-pear php5-dev -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \

    echo "extension=mongo.so" > /etc/php5/conf.d/mongo.ini


COPY php-cli.ini    /etc/php5/cli/conf.d/zz-custom-php.ini
COPY php-fpm.ini    /etc/php5/fpm/conf.d/zz-custom-php.ini
COPY www.conf       /etc/php5/fpm/pool.d/


# For custom Configuration that comes from outside (via a docker compose mount)
RUN mkdir /etc/php5/fpm/user-conf.d
RUN echo "; Default empty file" > /etc/php5/fpm/user-conf.d/example.conf
RUN mkdir /var/log/php

# Create home for www-data
RUN mkdir /home/www-data
RUN chown www-data:www-data /home/www-data
RUN usermod -d /home/www-data www-data


COPY run.sh     /run.sh
RUN  chmod +x    /run.sh

ENV ENVIRONMENT dev
ENV FPM_UID 33
ENV FPM_GID 33

EXPOSE 9000

CMD ["/run.sh"]
