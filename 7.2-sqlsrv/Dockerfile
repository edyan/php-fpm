FROM        edyan/php:7.2

ARG         DEBIAN_FRONTEND=noninteractive
ARG         BUILD_DATE
ARG         DOCKER_TAG
ARG         VCS_REF
ARG         ACCEPT_EULA=Y
ARG         MS_REMOTE_PACKAGE=https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
ARG         MS_LOCAL_PACKAGE=/tmp/packages-microsoft-prod.deb

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
