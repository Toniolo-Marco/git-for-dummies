#!/bin/bash

IMAGE_NAME="typst-runner:latest"

case $(uname -m) in
    x86_64)
        ARCH="x64"
        ;;
    aarch64)
        ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture"
        exit 1
        ;;
esac

echo "retrieving latest version number from release page"
LATEST=`curl -s -i https://github.com/actions/runner/releases/latest | grep location:`
LATEST=`echo $LATEST | sed 's#.*tag/v##'`
LATEST=`echo $LATEST | sed 's/\r//'`
echo "downloading latest GitHub runner (${LATEST})"

curl --progress-bar -L "https://github.com/actions/runner/releases/download/v${LATEST}/actions-runner-linux-${ARCH}-${LATEST}.tar.gz" -o runner.tgz

mkdir -p runner

echo "unpacking runner.tgz"
tar -zxf runner.tgz -C runner

docker build -t ${IMAGE_NAME} .

echo "cleaning"
rm -rf runner runner.tgz