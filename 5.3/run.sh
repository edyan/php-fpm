#!/bin/bash
CUSTOM_PHP_INI=/etc/php5/fpm/conf.d/zz-custom-php.ini

usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php

sed -i 's/^display_errors\s*=.*/display_errors = On/g' ${CUSTOM_PHP_INI}
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' ${CUSTOM_PHP_INI}

# If prod has been set ... "clean"
if [[ "$ENVIRONMENT" != "dev" ]]; then
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' ${CUSTOM_PHP_INI}
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' ${CUSTOM_PHP_INI}
fi

# Activate required modules
if [[ ! -z ${PHP_ENABLED_MODULES} ]]; then
    # Disable everything
    for MODULE in $(ls -1 /etc/php5/conf.d|cut -d'.' -f1); do
        echo "Disabling ${MODULE}"
        sed -i -E "s/^(zend_)?extension(.+)\.so$/; \1extension\2.so/g" /etc/php5/conf.d/${MODULE}.ini
    done

    echo ""

    # Re-enable what has been asked
    for MODULE in ${PHP_ENABLED_MODULES}; do
        echo "Enabling ${MODULE}"
        sed -i -E "s/^; (zend_)?extension(.+)\.so$/\1extension\2.so/g" /etc/php5/conf.d/${MODULE}.ini
    done
fi

exec /usr/sbin/php5-fpm -c /etc/php5/fpm
