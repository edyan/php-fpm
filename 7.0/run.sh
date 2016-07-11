#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data: /var/log/php
exec /usr/sbin/php-fpm7.0 --allow-to-run-as-root -c /etc/php7.0/fpm --nodaemonize
