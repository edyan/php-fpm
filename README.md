# iNet Process PHP FPM Docker Image
Docker Hub: https://hub.docker.com/r/inetprocess/php

Docker containers to expose PHP FPM with a specific version of PHP (5.3 -> 7.0) installed with main PHP extensions (curl, pdo, gd, etc ....) as well as XDebug. It's mainly made for development purposes.

The aim of these containers is to be used with docker-compose and especially with our Docker LAMP stack [inetprocess/lamp](https://github.com/inetprocess/docker-lamp)

## Usage
Add the following to your docker-compose.yml file:
```yaml
php:
    image: inetprocess/php
    environment:
        FPM_UID: 1000
        FPM_GID: 1000
    volumes_from:
        - app
    links:
        - mysql
```

## Environment variables
Two variables have been created (`FPM_UID` and `FPM_GID`) to override the www-data user and group ids. Giving the current user login / pass that runs the container, it will allow anybody to own the files read / written by the fpm daemon (started by www-data).

## Custom php.ini directives
If you need to alter the php configuration, you can mount a volume containing `.conf` files to `/etc/php5/fpm/user-conf.d/` for PHP 5.x or `/etc/php/7.0/fpm/user-conf.d/` for PHP 7.0.

Example:
```yaml
volumes:
    - ./conf/php-fpm-override:/etc/php5/fpm/user-conf.d
```

If you have a file named `conf/php-fpm-override/memory.conf` containing :
```conf
php_value[memory_limit] = 127M
```

The memory limit will be set to 127Mb. Be careful that you need to stop then start your container to make sure the parameters are taken into account.

## PHP version
To use a specific PHP version, append the version number to the image name.

Eg: `image: inetprocess/php:5.6`

The following PHP versions are available:

* PHP 7.0 (jessie stable)
* PHP 5.6 (jessie stable)
* PHP 5.5 (wheezy stable)
* PHP 5.4 (wheezy stable)
* PHP 5.3 (squeeze stable)
