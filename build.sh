#!/bin/bash
IMAGE=${IMAGE:-msteinhoff/rpm-docker-buildchain:latest}
COMMAND=${@:-/bin/bash}
docker run \
    -e XUID="$(id -u)" \
    -it \
    --rm \
    -v ${PWD}/rpmbuild:/rpmbuild:rw \
    ${IMAGE} \
    ${COMMAND}
