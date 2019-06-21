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

GIT_AVAILABLE=$(which git)
GIT_FILES_TO_COMMIT=$(git status --porcelain)
if [ "$GIT_AVAILABLE" != "" -a "$GIT_FILES_TO_COMMIT" != "" ]; then
    echo "You must make sure Git repo has been commited" >&2
    exit 1
fi

cd $1

echo "Building ${TAG}"
docker build . --tag ${TAG} \
               --cache-from ${TAG} \
               --build-arg BUILD_DATE="$(date -u +'%Y-%m-%dT%H:%M:%SZ')" \
               --build-arg VCS_REF="$(git rev-parse --short HEAD)" \
               --build-arg DOCKER_TAG="${TAG}"

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
    echo "  docker run -ti --rm ${TAG} /bin/bash"
    echo "To push that version (and other of the same repo):"
    echo "  docker push edyan/php"
fi
