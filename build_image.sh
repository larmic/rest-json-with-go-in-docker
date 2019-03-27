#!/usr/bin/env bash

declare -r IMAGE_NAME="larmic/channel-mock"
declare -r IMAGE_TAG="latest"

echo "Building image '$IMAGE_NAME:$IMAGE_TAG'..."
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .

echo "Prune intermediate images"
docker image prune --filter label=stage=intermediate -f
