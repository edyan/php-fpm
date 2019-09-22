[![Layers](https://images.microbadger.com/badges/image/edyan/php.svg)](https://microbadger.com/images/edyan/php "Get your own image badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/edyan/php.svg)](https://hub.docker.com/r/edyan/php/)
[![Build Status](https://travis-ci.com/edyan/docker-php.svg?branch=master)](https://travis-ci.com/edyan/docker-php)

# PHP FPM Docker Image
Docker Hub: https://hub.docker.com/r/edyan/php

Docker containers to expose PHP FPM with a specific version of PHP (5.3 -> 7.3) installed
with main PHP extensions (curl, pdo, gd, etc ....) as well as XDebug.

It's mainly made for development purposes but can also be used as Production.

The aim of these containers is to be used with docker-compose and especially with
[our Stakkr Tool](https://github.com/stakkr-org/stakkr).

**Why using Debian / Ubuntu and not the official PHP images?**
*Because a lot of hosts are based on Debian or Ubuntu, so it's to have in development
the same environment than in dev*

We try to use, as much as possible, distros officials PHP versions to avoid extra repositories.

**Why iptables?**
*Because [stakkr](https://github.com/stakkr-org/stakkr) blocks SMTP ports to avoid a
lot of emails to be send during developments and by mistake*


## Usage
Add the following to your docker-compose.yml file:
```yaml
php:
    image: edyan/php:7.3
    environment:
        FPM_UID: 1000
        FPM_GID: 1000
        PHP_ENABLED_MODULES: "curl sqlite3"

```

## Environment variables
Two variables have been created (`FPM_UID` and `FPM_GID`) to override the www-data user and group ids.
Giving the current user login / pass that runs the container, it will allow anybody to own the files
read / written by the fpm daemon (started by www-data).

Another variable will activate / deactivate development modules: `ENVIRONMENT`.
Set to `dev` it'll change `max_execution_time` to `-1` and `display_errors` to `On`.
Set to something else (Example: `production`) it'll do the opposite.

Finally, it's possible to personnalize the enabled PHP modules by changing `PHP_ENABLED_MODULES`
and setting the list, separated with a space of modules to activate.
Example : `PHP_ENABLED_MODULES="curl sqlite3"`

## Custom php.ini directives
If you need to alter the php configuration, you can mount a volume containing `.conf` files to
 `/etc/php5/fpm/user-conf.d/` for PHP 5.x or `/etc/php/7.x/fpm/user-conf.d/` for PHP 7.x

Example:
```yaml
volumes:
    - ./conf/php-fpm-override:/etc/php/current/fpm/user-conf.d
```

If you have a file named `conf/php-fpm-override/memory.conf` containing :
```conf
php_value[memory_limit] = 127M
```

The memory limit will be set to 127Mb. Be careful that you need to stop then start your container to make
sure the parameters are taken into account.

## PHP version
To use a specific PHP version, append the version number to the image name.

Eg: `image: edyan/php:7.2`

The following PHP versions are available:

* PHP 7.3 (buster slim + sury packages. **Be careful it's a BETA version**)
* PHP 7.3 (buster slim)
* PHP 7.2 (Ubuntu 18.04)
* PHP 7.1 (stretch slim + sury packages)
* PHP 7.0 (stretch slim)
* PHP 5.6 (jessie slim)
* PHP 5.5 (Ubuntu 14.04)
* PHP 5.4 (wheezy slim)
* PHP 5.3 (Ubuntu 12.04)


## Specific versions
### edyan/x.x-sqlsrv
That one has a driver for SQL Server (with MS Drivers).
