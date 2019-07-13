#!/bin/bash
set -e

DIR="$( cd "$( dirname "$0" )" && pwd )"

cd ${DIR}/../
for i in $(ls -d Dockerfile-*|sed -e "s/Dockerfile-/$1/g"); do
    PHP_VERSION=${i%%/}
    echo "Building and testing ${PHP_VERSION}"
    scripts/test.sh ${PHP_VERSION}|grep "Failed: "
    echo ""
    echo ""
done
