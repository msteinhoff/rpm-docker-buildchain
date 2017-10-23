#!/bin/bash
SPECNAME=${1}
TARGET_HOST=${TARGET_HOST}
TARGET_USER=${TARGET_USER:-yumrepo}
TARGET_DIST=${TARGET_DIST:-centos}
TARGET_RELVER=${TARGET_RELVER:-7}
TARGET_ARCH=${TARGET_ARCH:-x86_64}
SOURCE_DIRECTORY=rpmbuild/RPMS/${TARGET_ARCH}
TARGET_DIRECTORY=/var/db/yum/${TARGET_DIST}/${TARGET_RELVER}/${TARGET_ARCH}

[ -z "${TARGET_HOST}" ] && { echo "TARGET_HOST is empty"; exit 1; }
[ -z "${TARGET_USER}" ] && { echo "TARGET_USER is empty"; exit 1; }

publishsource() {
    SPECNAME=${1}
    SOURCE_RPMS=${SOURCE_DIRECTORY}/${SPECNAME}.rpm
    echo "RPMs to publish:"
    for RPM in ${SOURCE_RPMS};
    do
        echo "- $(basename ${RPM})"
    done
    echo ""
    echo "Publishing RPMs to ${TARGET_HOST}..."
    rsync -av ${SOURCE_RPMS} ${TARGET_USER}@${TARGET_HOST}:${TARGET_DIRECTORY}
    echo "Done."
}

updaterepomd() {
    echo "Updating repository metadata on ${TARGET_HOST}..."
    ssh ${TARGET_USER}@${TARGET_HOST} "cd ${TARGET_DIRECTORY}; createrepo --update ."
    echo "Done."
}

if [ -z "${SPECNAME}" ];
then
    publishsource "*"
    updaterepomd
else
    publishsource ${SPECNAME}*
    updaterepomd 
fi
