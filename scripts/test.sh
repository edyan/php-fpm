#!/bin/bash
set -e

if [[ -z "${1}" || ! -f "Dockerfile-${1}" ]]; then
    echo "You must define a valid image version to build as parameter"
    exit 1
fi

if [[ ! -f /tmp/dgoss ]]; then
    curl -sL https://raw.githubusercontent.com/goss-org/goss/master/extras/dgoss/dgoss -o /tmp/dgoss
    chmod +rx /tmp/dgoss
fi

VERSION=${1}
DIRECTORY="$( cd "$( dirname "$0" )" && pwd )"
TAG="${REGISTRY_PREFIX}edyan/php:${VERSION}"
GREEN='\033[0;32m'
NC='\033[0m' # No Color

cd
echo "Building image ${TAG}"
${DIRECTORY}/build.sh ${VERSION}

# List tests
declare -a "TESTS_5=(5.x/all_modules 5.x/few_modules)"
declare -a "TESTS_7=(7.x/all_modules 7.x/few_modules)"
declare -a "TESTS_8=(8.x/all_modules 7.x/few_modules)"

# Get tests and loop to run all
VERSION_MINOR="$( echo ${VERSION} | sed -e "s/-sqlsrv//g" )"
LIST_TESTS="TESTS_${VERSION::1}[@]"

# Get goss Path
export GOSS_PATH=/usr/local/bin/goss

for TESTS in ${!LIST_TESTS}; do
    echo ""
    echo -e "${GREEN}Testing version ${VERSION} with ${TESTS}${NC}"

    echo -e "${GREEN}Entering ${DIRECTORY}/../tests/${TESTS}${NC}"
    cd ${DIRECTORY}/../tests/${TESTS}

    SQLSRV=no
    if [[ ${VERSION} == *-sqlsrv ]]
    then
        SQLSRV=yes
    fi

    if [[ ${TESTS} == */few_modules ]]
    then
        /tmp/dgoss run -e VERSION=${VERSION_MINOR} -e GOSS_FILES_STRATEGY=cp -e SQLSRV=${SQLSRV} -e "PHP_ENABLED_MODULES=curl xml" ${TAG}
    else
        /tmp/dgoss run -e VERSION=${VERSION_MINOR} -e GOSS_FILES_STRATEGY=cp -e SQLSRV=${SQLSRV} ${TAG}
    fi
done
