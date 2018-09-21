FROM        ubuntu:14.04
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends
# Upgrade the system + Install all packages
RUN         apt update && \
            apt upgrade -y && \
            # Packages
            apt install -y \
                iptables \
                # php5-adodb \
                php5-apcu \
                # php5-cgi \
                php5-cli \
                php5-curl \
                # php5-dbg \
                # php5-dev \
                # php5-enchant \
                # php5-exactimage
                # php5-ffmpeg \
                php5-fpm \
                php5-gd \
                # php5-gdcm \
                # php5-gearman \
                php5-geoip \
                # php5-gmp \
                # php5-gnupg
                php5-imagick \
                php5-imap \
                # php5-interbase \
                php5-intl \
                php5-json \
                # php5-lasso \
                php5-ldap \
                # php5-librdf
                # php5-mapscript \
                php5-mcrypt \
                php5-memcache \
                # php5-memcached \
                # php5-ming \
                php5-mongo \
                # php5-mysql \
                php5-mysqlnd \
                # php5-odbc \
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
                php5-sqlite \
                # php5-spplus \
                # php5-svn \
                # php5-sybase \
                # php5-tidy \
                # php5-tokyo-tyrant \
                # php5-vtkgdcm \
                # php5-xcache \
                php5-xdebug \
                php5-xhprof \
                php5-xmlrpc \
                php5-xsl \
                libssh2-php && \
            # Clean
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*


COPY        php-cli.ini    /etc/php5/cli/conf.d/30-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/30-custom-php.ini
COPY        www.conf       /etc/php5/fpm/pool.d/

# Clean a deprecated comment in xhprof
RUN         sed -i 's/#/; /g' /etc/php5/fpm/conf.d/20-xhprof.ini

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
