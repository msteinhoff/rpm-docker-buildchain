#!/bin/bash
MODE=${1}
SPECNAME=${2}

removerpms() {
    echo "Removing RPMs..."
    rm -rf rpmbuild/RPMS/*
    echo "Done."
}

removesources() {
    for SOURCE in rpmbuild/SOURCES/*;
    do
        removesource ${SOURCE}
    done
}

removesource() {
    SOURCE=$1
    pushd $SOURCE > /dev/null 2>&1
    echo "Removing downloaded sources for $(basename ${SOURCE})"
    if [ -f ".gitignore" ];
    then
        cat .gitignore | sed '/^#.*/ d' | sed '/^\s*$/ d' | sed 's/^/rm -r /' | bash 2> /dev/null
    fi
    echo "Done."
    popd > /dev/null 2>&1
}

case $MODE in
    all)
        removerpms
        removesources
    ;;
    rpms)
        removerpms
    ;;
    sources)
        removesources
    ;;
    source)
        removesource ${SPECNAME}
    ;;
    *)
    echo "usage: $0 <all|rpms|sources|source) [name]"
    ;;
esac
