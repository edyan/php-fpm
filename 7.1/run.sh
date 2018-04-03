#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

# We'll say that we are by default in dev
phpenmod xdebug
phpenmod xhprof
sed -i 's/^display_errors\s*=.*/display_errors = On/g' /etc/php/7.1//fpm/conf.d/30-custom-php.ini
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' /etc/php/7.1/fpm/conf.d/30-custom-php.ini

# If prod has been set ... "clean"
if [ "$ENVIRONMENT" != "dev" ]; then
    phpdismod xdebug
    phpdismod xhprof
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' /etc/php/7.1/fpm/conf.d/30-custom-php.ini
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' /etc/php/7.1/fpm/conf.d/30-custom-php.ini
fi


exec /usr/sbin/php-fpm7.1 --allow-to-run-as-root -c /etc/php/7.1/fpm --nodaemonize
