#!/bin/bash
usermod -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data:www-data /var/log/php
exec /usr/sbin/php5-fpm --allow-to-run-as-root -c /etc/php5/fpm --nodaemonize
