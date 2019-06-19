FROM        edyan/php:7.1

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
            apt install -y curl gnupg && \
            echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/mssql.list && \
            curl -sS https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            apt update && \
            apt install -y \
                msodbcsql17 mssql-tools unixodbc unixodbc-dev php-pear php7.1-dev php7.1-sybase \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # Compile
            pecl install sqlsrv && \
            pecl install pdo_sqlsrv && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.1/mods-available/sqlsrv.ini && \
            ln -s /etc/php/7.1/mods-available/sqlsrv.ini /etc/php/7.1/cli/conf.d/20-sqlsrv.ini && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.1/mods-available/pdo_sqlsrv.ini && \
            ln -s /etc/php/7.1/mods-available/pdo_sqlsrv.ini /etc/php/7.1/cli/conf.d/20-pdo_sqlsrv.ini && \
            # Remove useless files installed for other PHP Versions
            rm -rf /usr/lib/php/20131226 /usr/lib/php/20151012 /usr/lib/php/20170718 && \
            rm -rf /etc/php/5.6 /etc/php/7.0 /etc/php/7.2 && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg unixodbc-dev php-pear php7.1-dev gcc g++ build-essential && \
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
