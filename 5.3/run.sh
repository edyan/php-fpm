#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

# We'll say that we are by default in dev
echo "; configuration for php xhprof module
extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini
echo "; configuration for php xdebug module
zend_extension=/usr/lib/php5/20090626/xdebug.so" > /etc/php5/conf.d/xdebug.ini

sed -i 's/^display_errors\s*=.*/display_errors = On/g' /etc/php5/fpm/conf.d/30-custom-php.ini
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' /etc/php5/fpm/conf.d/30-custom-php.ini

# If prod has been set ... "clean"
if [ "$ENVIRONMENT" != "dev" ]; then
    echo "; configuration for php xhprof module
; extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini
    echo "; configuration for php xdebug module
; zend_extension=/usr/lib/php5/20090626/xdebug.so" > /etc/php5/conf.d/xdebug.ini
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' /etc/php5/fpm/conf.d/30-custom-php.ini
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' /etc/php5/fpm/conf.d/30-custom-php.ini
fi

exec /usr/sbin/php5-fpm --allow-to-run-as-root -c /etc/php5/fpm --nodaemonize
