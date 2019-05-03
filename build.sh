#!/bin/bash

set -e

if [ -z "$1" -o ! -d "$1" ]; then
    echo "You must define a valid PHP version to build as parameter"
    exit 1
fi

VERSION=$1
GREEN='\033[0;32m'
NC='\033[0m' # No Color
TAG=edyan/php:${VERSION}

cd $1

echo "Building ${TAG}"
docker build -t ${TAG} .
if [[ "$VERSION" == "7.3" ]]; then
  echo ""
  echo "${TAG} will also be tagged 'latest'"
  docker tag ${TAG} edyan/php:latest
fi

echo ""
echo ""
if [ $? -eq 0 ]; then
    echo -e "${GREEN}Build Done${NC}."
    echo ""
    echo "Run :"
    echo "  docker run -d --rm --name php${VERSION}-test-ctn ${TAG}"
    echo "  docker exec -ti php${VERSION}-test-ctn /bin/bash"
    echo "Once Done : "
    echo "  docker stop php${VERSION}-test-ctn"
    echo ""
    echo "Or if you want to directly enter the container, then remove it : "
    echo "  docker run -ti --rm edyan_php${VERSION}_test /bin/bash"
    echo "To push that version (and other of the same repo):"
    echo "docker push edyan/php"
fi
