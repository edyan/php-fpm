#!/bin/bash

set -e

if [ -z "${1}" -o ! -d "${1}" ]; then
    echo "You must define a valid image version to build as parameter"
    exit 1
fi

DIRECTORY=$(cd `dirname $0` && pwd)
VERSION=${1}
TAG=edyan/php:${VERSION}
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo "Building image"
./build.sh ${VERSION} > /dev/null

echo ""
echo -e "${GREEN}Testing version ${VERSION} ${NC} with all modules"
cd ${DIRECTORY}/${VERSION}/tests/all_modules
export GOSS_FILES_STRATEGY=cp
dgoss run ${TAG}

if [[ -d ${DIRECTORY}/${VERSION}/tests/few_modules ]]; then
    echo -e "${GREEN}Testing version ${VERSION} ${NC} with only one module"
    cd ${DIRECTORY}/${VERSION}/tests/few_modules
    export GOSS_FILES_STRATEGY=cp
    dgoss run -e "PHP_ENABLED_MODULES=curl" ${TAG}
fi