FROM        edyan/php:7.3

ARG         BUILD_DATE
ARG         DEBIAN_FRONTEND=noninteractive
ARG         ACCEPT_EULA=Y
ARG         LIBSSL_STRETCH_DEB=http://ftp.us.debian.org/debian/pool/main/o/openssl1.0/libssl1.0.2_1.0.2r-1~deb9u1_amd64.deb

LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>"
LABEL       org.label-schema.build-date=$BUILD_DATE

RUN         apt update && \
            apt install -y curl gnupg && \
            echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/mssql.list && \
            curl -sS https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            apt update && \
            apt install -y \
                # To keep
                msodbcsql17 mssql-tools unixodbc php7.3-sybase \
                # remove later
                unixodbc-dev php-pear php7.3-dev  \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # Compile
            pecl install sqlsrv install pdo_sqlsrv && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.3/mods-available/sqlsrv.ini && \
            phpenmod sqlsrv && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.3/mods-available/pdo_sqlsrv.ini && \
            phpenmod pdo_sqlsrv && \
            # I need that to make it work (as we use debian stretch repo for mssql)
            curl $LIBSSL_STRETCH_DEB -s -o /tmp/libssl1.0.2_1.0.2r-1~deb9u1_amd64.deb && \
            dpkg -i /tmp/libssl1.0.2_1.0.2r-1~deb9u1_amd64.deb && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg unixodbc-dev php-pear php7.3-dev gcc g++ build-essential && \
            # Clean
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            # Empty some directories from all files and hidden files
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /build /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests

COPY        test.php /root/test.php

RUN         php /root/test.php

RUN         mkdir /var/log/php
