#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

if [ "$ENVIRONMENT" != "dev" ]; then
    php5dismod xdebug
    php5dismod xhprof
    sed -i 's/display_errors = On/display_errors = Off/g' /etc/php5/fpm/conf.d/30-custom-php.ini
    sed -i 's/max_execution_time = -1/max_execution_time = 60/g' /etc/php5/fpm/conf.d/30-custom-php.ini
fi

exec /usr/sbin/php5-fpm --allow-to-run-as-root -c /etc/php5/fpm --nodaemonize
