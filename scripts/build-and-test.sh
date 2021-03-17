#!/bin/bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."
BUILD_DIR=build

if [ -d ${BUILD_DIR} ]; then
    rm -rf ${BUILD_DIR}
fi

cmake -G Ninja -S "${PROJECT_DIR}" -B "${BUILD_DIR}" -DCMAKE_BUILD_TYPE=Debug
cmake --build "${BUILD_DIR}"
cd "${BUILD_DIR}"
ctest -T memcheck -V

files=./Testing/Temporary/MemoryChecker.*.log
for file in ${files}; do
    if [ -s ${file} ]; then
        cat ${files}
        exit 1
    fi
done
