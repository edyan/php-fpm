FROM debian:jessie
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>


# DotDeb configuration + Upgrade the system
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates curl && \

    echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    curl -sS http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \

    echo "deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main" >> /etc/apt/sources.list.d/tideways.list && \
    curl -sS https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get purge curl -y && \
    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*



RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php7.0-cli \
    php7.0-curl \
    php7.0-fpm \
    php7.0-gd \
    php7.0-geoip \
    php7.0-imagick \
    php7.0-imap \
    php7.0-intl \
    php7.0-json \
    php7.0-ldap \
    php7.0-mcrypt \
    php7.0-mongodb \
    php7.0-mysqlnd \
    php7.0-opcache \
    php7.0-odbc \
    php7.0-pgsql \
    php7.0-sqlite \
    php7.0-ssh2 \
    php7.0-tidy \
    php7.0-xdebug \
    php7.0-xsl \
    php7.0-zip \
    tideways-php && \

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
