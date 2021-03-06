#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PACKAGE_NAME=$(basename "$SCRIPT_DIR")
mkdir -p ${SCRIPT_DIR}/bin
PACKAGE_BIN_DIR=${SCRIPT_DIR}/bin

rm ${PACKAGE_BIN_DIR}/${PACKAGE_NAME}-*

GOOS=darwin
go build
mv ${PACKAGE_NAME} ${PACKAGE_BIN_DIR}/${PACKAGE_NAME}-${GOOS}

GOOS=linux
go build
mv ${PACKAGE_NAME} ${PACKAGE_BIN_DIR}/${PACKAGE_NAME}-${GOOS}

GOOS=windows
go build
mv ${PACKAGE_NAME}.exe ${PACKAGE_BIN_DIR}/${PACKAGE_NAME}-${GOOS}.exe

git log --pretty=format:"- %cd: %s%n%b" --date=short  > CHANGELOG

# zip ${PACKAGE_NAME}.zip ${PACKAGE_NAME}-*