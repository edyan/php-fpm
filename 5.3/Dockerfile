FROM        ubuntu:12.04

ARG         BUILD_DATE
ARG         DEBIAN_FRONTEND=noninteractive

LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>"
LABEL       org.label-schema.build-date=$BUILD_DATE

# Set a default conf for apt install
RUN         echo 'apt::install-recommends "false";' > /etc/apt/apt.conf.d/no-install-recommends && \
            # Upgrade the system + Install all packages
            apt-get update && \
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
            # Build tools
            apt-get install --force-yes -y build-essential pkg-config libssl-dev php-pear php5-dev && \
            # pear for mongo
            pecl channel-update pecl.php.net && \
            pecl install mongo xhprof-beta && \
            rm -Rf /tmp/pear && \
            # Activate extension
            echo "extension=mongo.so" > /etc/php5/conf.d/mongo.ini && \
            echo "extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini && \
            # Clean
            apt-get purge build-essential pkg-config libssl-dev php-pear php5-dev -y && \
            apt-get autoremove -y && \
            apt-get autoclean && \
            apt-get clean && \
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /build /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests

COPY        php-cli.ini    /etc/php5/cli/conf.d/zz-custom-php.ini
COPY        php-fpm.ini    /etc/php5/fpm/conf.d/zz-custom-php.ini
COPY        www.conf       /etc/php5/fpm/pool.d/


# Make sure fpm will not be daemonized
RUN         sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php5/fpm/php-fpm.conf

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
