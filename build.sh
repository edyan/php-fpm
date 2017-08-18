#!/bin/bash

set -e

if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi
cd $1
docker build -t "inet_php_test" .
echo ""
echo ""
if [ $? -eq 0 ]; then
    echo -e "\x1b[1;32mBuild Done. To run it: \e[0m"
    echo '  docker run -d --rm --hostname "php-test-ctn" --name "php-test-ctn" inet_php_test'
    echo '  docker exec -i -t "php-test-ctn" /bin/bash'
    echo "Once Done : "
    echo '  docker stop "php-test-ctn"'
    echo ""
    echo "Or if you want to directly enter the container, then remove it : "
    echo '  docker run -ti --rm inet_php_test /bin/bash'
fi
