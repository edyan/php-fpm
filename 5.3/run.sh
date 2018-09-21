#!/bin/bash
CUSTOM_PHP_INI=/etc/php5/fpm/conf.d/zz-custom-php.ini

usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

# We'll say that we are by default in dev
echo "; configuration for php xhprof module
extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini
echo "; configuration for php xdebug module
zend_extension=/usr/lib/php5/20090626/xdebug.so" > /etc/php5/conf.d/xdebug.ini

sed -i 's/^display_errors\s*=.*/display_errors = On/g' ${CUSTOM_PHP_INI}
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' ${CUSTOM_PHP_INI}

# If prod has been set ... "clean"
if [ "$ENVIRONMENT" != "dev" ]; then
    echo "; configuration for php xhprof module
; extension=xhprof.so" > /etc/php5/conf.d/xhprof.ini
    echo "; configuration for php xdebug module
; zend_extension=/usr/lib/php5/20090626/xdebug.so" > /etc/php5/conf.d/xdebug.ini
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' ${CUSTOM_PHP_INI}
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' ${CUSTOM_PHP_INI}
fi

exec /usr/sbin/php5-fpm -c /etc/php5/fpm
