#!/bin/bash
if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi
cd $1
docker build -t "inet_php_test" .
echo ""
echo ""
if [ $? -eq 0 ]; then
    # docker run -e "FPM_UID=1000" -e "FPM_GID=1000" --hostname php-ctn --name php inet_php_test
    echo -e "\x1b[1;32mBuild Done\e[0m"
fi
