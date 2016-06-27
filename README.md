# iNet Process PHP FPM Docker Image

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
Two variables have been created (`FPM_UID` and `FPM_GID`) to override the www-data user and group ids. Taking the current user login / pass that runs the container, it will allow anoybody to own the files read / written by the fpm daemon (owned by www-data).


## PHP version
To use a specific PHP version, append the version number to the image name.

Eg: `image: inetprocess/php:5.6`

The following PHP versions are available:

* PHP 7.0 (jessie stable)
* PHP 5.6 (jessie stable)
* PHP 5.5 (wheezy stable)
* PHP 5.4 (wheezy stable)
* PHP 5.3 (squeeze stable)
