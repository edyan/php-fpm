FROM debian:jessie
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils ca-certificates curl vim && \
    apt-get clean && \
    rm -Rf /var/lib/apt/lists/* \
    rm -Rf /usr/share/man/* /usr/share/doc/*

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    php-pear \
    php5-apcu \
    php5-cli \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-imagick \
    php5-imap \
    php5-intl \
    php5-json \
    php5-mcrypt \
    php5-memcached \
    php5-mysql \
    php5-sqlite \
    php5-tidy \
    php5-xdebug \
    php5-xsl && \
    apt-get clean && \
    rm -Rf /var/lib/apt/lists/* \
    rm -Rf /usr/share/man/* /usr/share/doc/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY php.ini    /etc/php5/fpm/conf.d/
COPY php.ini    /etc/php5/cli/conf.d/
COPY www.conf   /etc/php5/fpm/pool.d/

RUN mkdir /var/log/php

COPY run.sh     /run.sh
RUN  chmod +x    /run.sh

ENV ENVIRONMENT dev
ENV FPM_UID 33
ENV FPM_GID 33

EXPOSE 9000

CMD ["/run.sh"]
