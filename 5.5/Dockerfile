FROM        debian:wheezy-slim
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# DotDeb configuration + Upgrade the system
RUN         apt-get update && \
            # Install minimum requirements
            apt-get install -y --no-install-recommends ca-certificates curl && \
            # Setup DotDeb Repos
            echo "deb http://packages.dotdeb.org wheezy-php55 all" >> /etc/apt/sources.list.d/dotdeb-php55.org.list && \
            curl -sS http://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
            apt-get update && \
            # Install PHP
            apt-get install -y --no-install-recommends \
                iptables \
                # php5-adodb \
                php5-apcu \
                # php5-cgi \
                php5-cli \
                # php5-common \
                php5-curl \
                # php5-dbg \
                # php5-dev \
                # php5-enchant \
                # php5-ffmpeg \
                php5-fpm \
                php5-gd \
                # php5-gdcm \
                # php5-gearman \
                php5-geoip \
                php5-gmp \
                php5-imagick \
                php5-imap \
                php5-interbase \
                php5-intl \
                php5-json \
                # php5-lasso \
                php5-ldap \
                # php5-mapscript \
                php5-mcrypt \
                php5-memcache \
                # php5-memcached \
                # php5-ming \
                php5-mongo \
                # php5-mysql \
                php5-mysqlnd \
                php5-odbc \
                php5-pgsql \
                # php5-pinba \
                # php5-ps \
                php5-pspell \
                # php5-radius \
                php5-readline \
                php5-recode \
                php5-redis \
                # php5-remctl \
                # php5-rrd \
                # php5-sasl \
                # php5-snmp \
                # php5-spplus \
                php5-sqlite \
                php5-ssh2 \
                # php5-svn \
                # php5-sybase \
                # php5-tidy \
                # php5-tokyo-tyrant \
                # php5-vtkgdcm \
                # php5-xcache \
                php5-xdebug \
                php5-xhprof \
                php5-xmlrpc \
                php5-xsl && \
            # Clean
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*


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
