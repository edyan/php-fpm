#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

PHP_VERSION=7.2

# We'll say that we are by default in dev
sed -i 's/^display_errors\s*=.*/display_errors = On/g' /etc/php/${PHP_VERSION}//fpm/conf.d/30-custom-php.ini
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' /etc/php/${PHP_VERSION}/fpm/conf.d/30-custom-php.ini

# If prod has been set ... "clean"
if [ "$ENVIRONMENT" != "dev" ]; then
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' /etc/php/${PHP_VERSION}/fpm/conf.d/30-custom-php.ini
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' /etc/php/${PHP_VERSION}/fpm/conf.d/30-custom-php.ini
fi

# Activate required modules
EXT_DIR=$(php -i | grep ^extension_dir | cut -d'=' -f2 | cut -d' ' -f2)
if [[ ! -z ${PHP_ENABLED_MODULES} && ! -z ${EXT_DIR} ]]; then
    # Disable everything
    for MODULE in $(ls -1 ${EXT_DIR}|cut -d'.' -f1); do
        phpdismod -v ALL -s ALL ${MODULE}
    done

    for MODULE in ${PHP_ENABLED_MODULES}; do
        phpenmod -v ALL -s ALL ${MODULE}
    done
fi

exec /usr/sbin/php-fpm${PHP_VERSION} --allow-to-run-as-root -c /etc/php/${PHP_VERSION}/fpm --nodaemonize
