# Inet PHP FPM Docker Image

## Usage

Add the following to your docker-compose.yml file:

```YAML
php:
    image: inet/php
    environment:
        FPM_UID: 1000
        FPM_GID: 1000
    volumes_from:
        - app
    links:
        - mysql
```

## PHP version

To use a specific PHP version, append the version number to the image name.

Eg: `image: inet/php:5.6`

The following PHP versions are available:

* PHP 7.0.0 (jessie stable)
* PHP 5.6 (jessie stable)
* PHP 5.4 (wheezy stable)
* PHP 5.3 (squeeze stable)

