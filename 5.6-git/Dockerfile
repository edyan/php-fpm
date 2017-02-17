FROM debian:jessie
MAINTAINER Emmanuel Dyan <emmanuel.dyan@inetprocess.com>

# Upgrade the system and Install PHP
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \

    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \

    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    ca-certificates \
    git \
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
    php5-mysqlnd \
    php5-odbc \
    php5-pgsql \
    php5-sqlite \
    php5-ssh2 \
    php5-tidy \
    php5-xcache \
    php5-xdebug \
    php5-xhprof \
    php5-xsl && \
    php5enmod xhprof && \

    # Because of a wrong comment in the official xhprof ini file
    echo "extension = xhprof.so" > /etc/php5/cli/conf.d/20-xhprof.ini && \

    DEBIAN_FRONTEND=noninteractive apt-get autoremove -y && \
    DEBIAN_FRONTEND=noninteractive apt-get clean && \
    rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


COPY php-cli.ini    /etc/php5/cli/conf.d/30-custom-php.ini
COPY php-fpm.ini    /etc/php5/fpm/conf.d/30-custom-php.ini
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
