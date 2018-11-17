FROM        edyan/php:7.3
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive
ARG         ACCEPT_EULA=Y

# Setup MS repo and install SQL Server client
RUN         apt update && \
            apt install -y curl gnupg && \
            curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/microsoft.list && \
            apt update && \
            apt upgrade -y && \
            apt install -y \
                # To keep
                msodbcsql17 mssql-tools unixodbc php7.3-sybase \
                # remove later
                unixodbc-dev php-pear php7.3-dev  \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # upgrade Tar as it contains a bug
            cd /tmp && \
            curl http://download.pear.php.net/package/Archive_Tar-1.4.3.tgz --output Archive_Tar-1.4.3.tgz && \
            tar -zxf Archive_Tar-1.4.3.tgz && \
            cp /tmp/Archive_Tar-1.4.3/Archive/Tar.php /usr/share/php/Archive/Tar.php && \
            # Compile
            pecl install sqlsrv-5.4.0preview && \
            pecl install pdo_sqlsrv-5.4.0preview && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.3/mods-available/sqlsrv.ini && \
            ln -s /etc/php/7.3/mods-available/sqlsrv.ini /etc/php/7.3/cli/conf.d/20-sqlsrv.ini && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.3/mods-available/pdo_sqlsrv.ini && \
            ln -s /etc/php/7.3/mods-available/pdo_sqlsrv.ini /etc/php/7.3/cli/conf.d/20-pdo_sqlsrv.ini && \
            # Remove useless packages / files
            apt purge --autoremove -y \
                curl gnupg \
                unixodbc-dev php-pear php7.3-dev gcc g++ build-essential && \
            # I need that to make it work
            apt install -y libssl1.0 && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -Rf /build /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/* /tmp/*

COPY        test.php /root/test.php

RUN         php /root/test.php

RUN         mkdir /var/log/php
