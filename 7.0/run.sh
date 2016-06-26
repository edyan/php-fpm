#!/bin/bash
mkdir -p /home/www-data
chown www-data: /home/www-data
usermod -d /home/www-data -u $FPM_UID www-data
groupmod -g $FPM_GID www-data
chown www-data: /var/log/php

mkdir /run/php
chown www-data: /run/php

exec /usr/sbin/php-fpm7.0 --allow-to-run-as-root -c /etc/php7.0/fpm --nodaemonize
