#!/bin/bash
TAG="v1.4.0"
IMAGE="${IMAGE:-devopsairwallex/k8s-pod-restart-info-collector}"
# One multi-arch index (amd64 + arm64) pushed under both tags. A multi-platform build cannot be
# loaded into the local image store, so it is pushed straight from buildx.
docker buildx build --platform linux/amd64,linux/arm64 -t "${IMAGE}:${TAG}" -t "${IMAGE}:latest" --push .
