FROM        edyan/php:7.0

ARG         DEBIAN_FRONTEND=noninteractive
ARG         ACCEPT_EULA=Y
ARG         BUILD_DATE
ARG         DOCKER_TAG
ARG         VCS_REF

LABEL       maintainer="Emmanuel Dyan <emmanueldyan@gmail.com>" \
            org.label-schema.build-date=$BUILD_DATE \
            org.label-schema.name=$DOCKER_TAG \
            org.label-schema.description="Docker PHP Image based on Debian and including main modules" \
            org.label-schema.url="https://cloud.docker.com/u/edyan/repository/docker/edyan/php" \
            org.label-schema.vcs-url="https://github.com/edyan/docker-php" \
            org.label-schema.vcs-ref=$VCS_REF \
            org.label-schema.schema-version="1.0" \
            org.label-schema.vendor="edyan" \
            org.label-schema.version=$VERSION \
            org.label-schema.docker.cmd="docker run -d --rm $DOCKER_TAG"

RUN         apt update && \
            apt install -y apt-transport-https curl gnupg && \
            echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/mssql.list && \
            curl -sS https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            apt update && \
            apt install -y \
                msodbcsql17 mssql-tools unixodbc unixodbc-dev php-pear php7.0-dev php7.0-sybase \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # Compile
            pecl install sqlsrv-5.3.0 pdo_sqlsrv-5.3.0 && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.0/mods-available/sqlsrv.ini && \
            ln -s /etc/php/7.0/mods-available/sqlsrv.ini /etc/php/7.0/cli/conf.d/20-sqlsrv.ini && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.0/mods-available/pdo_sqlsrv.ini && \
            ln -s /etc/php/7.0/mods-available/pdo_sqlsrv.ini /etc/php/7.0/cli/conf.d/20-pdo_sqlsrv.ini && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg unixodbc-dev php-pear php7.0-dev gcc g++ build-essential && \
            # Clean
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            # Empty some directories from all files and hidden files
            find /root /tmp -mindepth 1 -delete && \
            rm -rf /build /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* \
                   /var/cache/* /var/log/* /usr/share/php/docs /usr/share/php/tests

COPY        test.php /root/test.php

RUN         mkdir /var/log/php
