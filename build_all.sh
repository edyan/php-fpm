#!/bin/bash
for i in $(ls -d */); do
    PHP_VERSION=${i%%/}
    echo "Building and testing ${PHP_VERSION}"
    if [[ -f ${PHP_VERSION}/Dockerfile ]]; then
        ./test.sh ${PHP_VERSION}|grep "Failed: "
    fi
    echo ""
    echo ""
done
