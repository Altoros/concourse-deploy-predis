#!/usr/bin/env bash -e
# ./build-and-push allomov/deploy-worker

IMAGE_NAME=${1:-allomov/deploy-worker}
VERSION=${2:-latest}

docker build --no-cache=true -t $IMAGE_NAME:$VERSION -f docker/deploy-worker.Dockerfile .
docker push $IMAGE_NAME
