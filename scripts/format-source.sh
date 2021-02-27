#!/bin/bash

set -Eeuo pipefail #bash strict mode

fail() {
    echo process failed!
    exit 1
}

trap fail ERR SIGINT SIGTERM SIGKILL

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

find "$PROJECT_DIR/src" \
    \( -name '*.c' \
    -o -name '*.cc' \
    -o -name '*.cpp' \
    -o -name '*.h' \
    -o -name '*.hh' \
    -o -name '*.hpp' \) \
-exec "clang-format" -i '{}' \;
