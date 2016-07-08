#!/bin/bash
if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi
cd $1
docker build -t "inetprocesstestphp" .
echo ""
echo ""
if [ $? -eq 0 ]; then
    # docker run -v example.cnf:/etc/php5/fpm/user-conf.d/mounted.conf -e "FPM_UID=1000" -e "FPM_GID=1000" inetprocesstestphp
    echo -e "\x1b[1;32mBuild Done\e[0m"
fi
