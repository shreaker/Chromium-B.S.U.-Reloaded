#!/bin/bash

set -Eeuo pipefail #bash strict mode

fail() {
    echo process failed!
    exit 1
}

trap fail ERR SIGINT SIGTERM SIGKILL

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
BUILD_DIR=build

if [ -d ${BUILD_DIR} ]; then
    rm -rf ${BUILD_DIR}
fi

cmake -G Ninja -S "${PROJECT_DIR}" -B "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Release
cmake --build "${BUILD_DIR}"
cd "${BUILD_DIR}"
cpack
