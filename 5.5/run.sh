#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

# We'll say that we are by default in dev
php5enmod xdebug
php5enmod xhprof
sed -i 's/^display_errors\s*=.*/display_errors = On/g' /etc/php5/fpm/conf.d/30-custom-php.ini
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' /etc/php5/fpm/conf.d/30-custom-php.ini

# If prod has been set ... "clean"
if [ "$ENVIRONMENT" != "dev" ]; then
    php5dismod xdebug
    php5dismod xhprof
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' /etc/php5/fpm/conf.d/30-custom-php.ini
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' /etc/php5/fpm/conf.d/30-custom-php.ini
fi


exec /usr/sbin/php5-fpm --allow-to-run-as-root -c /etc/php5/fpm --nodaemonize
