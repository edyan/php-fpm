#!/bin/bash
if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi
cd $1
docker build -t "inetprocesstestphp${1}" .
echo ""
echo ""
if [ $? -eq 0 ]; then
    #docker run -e "PHP_GID=1000" inetprocesstestphp${1}
    echo -e "\x1b[1;32mBuild Done\e[0m"
fi
