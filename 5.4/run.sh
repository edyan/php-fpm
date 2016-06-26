#!/bin/bash
mkdir -p /home/www-data
chown www-data: /home/www-data
usermod -d /home/www-data -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data: /var/log/php
exec /usr/sbin/php5-fpm --allow-to-run-as-root -c /etc/php5/fpm --nodaemonize
