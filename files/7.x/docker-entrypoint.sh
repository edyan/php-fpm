#!/bin/bash
set -e

CURRENT_FPM_ID=$(id -u www-data)
if [[ "${CURRENT_FPM_ID}" != "${FPM_UID}" ]]; then
    echo "Fixing permissions for php-fpm"
    usermod -u ${FPM_UID:=33} www-data
    groupmod -g ${FPM_GID:=33} www-data
fi

# We'll say that we are by default in dev
sed -i 's/^display_errors\s*=.*/display_errors = On/g' /etc/php/current/fpm/conf.d/30-custom-php.ini
sed -i 's/^max_execution_time\s*=.*/max_execution_time = -1/g' /etc/php/current/fpm/conf.d/30-custom-php.ini

# If prod has been set ... "clean"
if [[ "${ENVIRONMENT:=dev}" != "dev" ]]; then
    sed -i 's/^display_errors\s*=.*/display_errors = Off/g' /etc/php/current/fpm/conf.d/30-custom-php.ini
    sed -i 's/^max_execution_time\s*=.*/max_execution_time = 60/g' /etc/php/current/fpm/conf.d/30-custom-php.ini
fi

# Activate required modules
EXT_DIR=$(php -i | grep ^extension_dir | cut -d'=' -f2 | cut -d' ' -f2)
if [[ ! -z ${PHP_ENABLED_MODULES} && ! -z ${EXT_DIR} ]]; then
    # Disable everything
    for MODULE in $(ls -1 ${EXT_DIR}|cut -d'.' -f1); do
        echo "Disabling ${MODULE}"
        phpdismod -v ALL -s ALL ${MODULE}
    done

    for MODULE in ${PHP_ENABLED_MODULES}; do
        echo "Enabling ${MODULE}"
        phpenmod -v ALL -s ALL ${MODULE}
    done
fi

exec "$@"
