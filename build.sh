#!/bin/bash
if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi
cd $1
docker build -t "inetprocess:testphp${1}" .
docker run -e "PHP_GID=1000" inetprocess:testapache${1}
