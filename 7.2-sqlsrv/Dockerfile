FROM        edyan/php:7.2
MAINTAINER  Emmanuel Dyan <emmanueldyan@gmail.com>

ARG         DEBIAN_FRONTEND=noninteractive
ARG         ACCEPT_EULA=Y

# sury configuration + Upgrade the system + Install all packages
RUN         apt update && \
            apt install -y curl gnupg && \
            echo "deb [arch=amd64] https://packages.microsoft.com/debian/9/prod stretch main" > /etc/apt/sources.list.d/mssql.list && \
            curl -sS https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
            apt update && \
            apt install -y \
                msodbcsql17 mssql-tools unixodbc unixodbc-dev php-pear php7.2-dev php7.2-sybase \
                gcc g++ build-essential && \
            # sqlsrv from PECL
            pecl channel-update pecl.php.net && \
            # upgrade Tar as it contains a bug
            cd /tmp && \
            curl http://download.pear.php.net/package/Archive_Tar-1.4.3.tgz --output Archive_Tar-1.4.3.tgz && \
            tar -zxf Archive_Tar-1.4.3.tgz && \
            cp /tmp/Archive_Tar-1.4.3/Archive/Tar.php /usr/share/php/Archive/Tar.php && \
            # Compile
            pecl install sqlsrv && \
            pecl install pdo_sqlsrv && \
            # Activate
            echo "extension=sqlsrv.so" > /etc/php/7.2/mods-available/sqlsrv.ini && \
            ln -s /etc/php/7.2/mods-available/sqlsrv.ini /etc/php/7.2/cli/conf.d/20-sqlsrv.ini && \
            echo "extension=pdo_sqlsrv.so" > /etc/php/7.2/mods-available/pdo_sqlsrv.ini && \
            ln -s /etc/php/7.2/mods-available/pdo_sqlsrv.ini /etc/php/7.2/cli/conf.d/20-pdo_sqlsrv.ini && \
            # Remove useless files installed for other PHP Versions
            rm -rf /usr/lib/php/20131226 /usr/lib/php/20151012 /usr/lib/php/20160303 /usr/lib/php/7.1 && \
            rm -rf /etc/php/5.6 /etc/php/7.0 /etc/php/7.1 && \
            # Remove useless packages / files
            apt purge --autoremove -y curl gnupg unixodbc-dev php-pear php7.2-dev gcc g++ build-essential && \
            apt autoremove -y && \
            apt autoclean && \
            apt clean && \
            rm -Rf /build /root/.bashrc /root/.profile /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/* /var/cache/* /var/log/*

RUN         mkdir /var/log/php
