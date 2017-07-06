#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php
exec /usr/sbin/php-fpm7.1 --allow-to-run-as-root -c /etc/php7.1/fpm --nodaemonize
