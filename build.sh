#!/bin/bash
IMAGE=${IMAGE:-centos7-rpmbuild}
COMMAND=${@:-/bin/bash}

docker build -t ${IMAGE} docker/${IMAGE}
docker run \
    -e XUID="$(id -u)" \
    -it \
    --rm \
    -v ${PWD}/rpmbuild:/rpmbuild:rw \
    ${IMAGE} \
    ${COMMAND}
