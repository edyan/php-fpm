FROM        edyan/php:7.2
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive
ARG         ACCEPT_EULA=Y
ARG         MS_REMOTE_PACKAGE=https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
ARG         MS_LOCAL_PACKAGE=/tmp/packages-microsoft-prod.deb

RUN         apt update && \
            apt install -y curl gnupg && \
            curl $MS_REMOTE_PACKAGE --output $MS_LOCAL_PACKAGE && \
            dpkg -i $MS_LOCAL_PACKAGE && \
            apt update && \
            apt install -y \
                # To keep
                msodbcsql17 mssql-tools unixodbc php7.2-sybase \
                # remove later
                unixodbc-dev php-pear php7.2-dev  \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # Compile
            pecl install sqlsrv pdo_sqlsrv && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.2/mods-available/sqlsrv.ini && \
            ln -s /etc/php/7.2/mods-available/sqlsrv.ini /etc/php/7.2/cli/conf.d/20-sqlsrv.ini && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.2/mods-available/pdo_sqlsrv.ini && \
            ln -s /etc/php/7.2/mods-available/pdo_sqlsrv.ini /etc/php/7.2/cli/conf.d/20-pdo_sqlsrv.ini && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg unixodbc-dev php-pear php7.2-dev gcc g++ build-essential && \
            # I need that to make it work
            apt install -y libssl1.0 && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            # Empty some directories from all files and hidden files
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests

COPY        test.php /root/test.php

RUN         php /root/test.php

RUN         mkdir /var/log/php
