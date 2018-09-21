FROM        ubuntu:12.04
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends
# Upgrade the system + Install all packages
RUN         apt-get update && \
            # Install all packages below :
            apt-get install -y \
                # IPtables for stakkr
                iptables \
                # PHP Modules
                # php5-adodb \
                # php5-auth-pam \
                # php5-cgi \
                php5-cli \
                php5-curl \
                # php5-dbg \
                # php5-dev \
                # php5-enchant \
                # php5-exactimage \
                # php5-ffmpeg \
                php5-fpm \
                php5-gd \
                php5-geoip \
                # php5-gmp \
                php5-imagick \
                php5-imap \
                # php5-interbase \
                php5-intl \
                # php5-lasso \
                php5-ldap \
                # php5-librdf \
                # php5-mapscript \
                php5-mcrypt \
                php5-memcache \
                php5-memcached \
                # php5-midgard2 \
                # php5-ming \
                # php5-mysql \
                php5-mysqlnd \
                # php5-odbc \
                php5-pgsql \
                # php5-ps \
                php5-pspell \
                # php5-radius \
                # php5-recode \
                # php5-remctl \
                # php5-rrd \
                # php5-sasl \
                # php5-snmp \
                php5-sqlite \
                # php5-suhosin \
                # php5-svn \
                # php5-sybase \
                # php5-tidy \
                # php5-tokyo-tyrant \
                # php5-uuid \
                # php5-xcache \
                php5-xdebug \
                php5-xmlrpc \
                php5-xsl \
                php-apc \
                libssh2-php && \
            # Clean and save space
            apt-get clean && \
            rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*


# Install xhprof and mongo
RUN         apt-get update && \
            # Build tools
            apt-get install --force-yes -y build-essential php-pear php5-dev && \
            # pear for mongo
            pecl channel-update pecl.php.net && \
            pecl install -f mongo xhprof && \
            rm -Rf /tmp/pear && \
            # Activate extension
            echo "extension=mongo.so" > /etc/php5/conf.d/mongo.ini && \
            echo "extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini && \
            # Clean
            apt-get purge build-essential php-pear php5-dev -y && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

COPY        php-cli.ini    /etc/php5/cli/conf.d/zz-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/zz-custom-php.ini
COPY        www.conf       /etc/php5/fpm/pool.d/


# Make sure fpm will not be daemonized
RUN         sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

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
