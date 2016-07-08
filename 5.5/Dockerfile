FROM debian:wheezy
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils ca-certificates curl vim && \
    apt-get clean && \
    rm -Rf /var/lib/apt/lists/* \
    rm -Rf /usr/share/man/* /usr/share/doc/*

RUN echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb-php55.org.list && \
    curl -sS http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php5-apcu \
    php5-cli \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-geoip \
    php5-imagick \
    php5-imap \
    php5-intl \
    php5-json \
    php5-ldap \
    php5-mcrypt \
    php5-mongo \
    php5-mysqli \
    php5-odbc \
    php5-pgsql \
    php5-sqlite \
    php5-ssh2 \
    php5-tidy \
    php5-xcache \
    php5-xdebug \
    php5-xhprof \
    php5-xsl && \
    apt-get clean && \
    rm -Rf /var/lib/apt/lists/* \
    rm -Rf /usr/share/man/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY php-cli.ini    /etc/php5/cli/conf.d/30-custom-php.ini
COPY php-fpm.ini    /etc/php5/fpm/conf.d/30-custom-php.ini
COPY www.conf       /etc/php5/fpm/pool.d/

# For custom Configuration that comes from outside (via a docker compose mount)
RUN mkdir /etc/php5/fpm/user-conf.d
RUN echo "; Default empty file" > /etc/php5/fpm/user-conf.d/example.conf
RUN mkdir /var/log/php

COPY run.sh     /run.sh
RUN  chmod +x    /run.sh

ENV ENVIRONMENT dev
ENV FPM_UID 33
ENV FPM_GID 33

EXPOSE 9000

CMD ["/run.sh"]
