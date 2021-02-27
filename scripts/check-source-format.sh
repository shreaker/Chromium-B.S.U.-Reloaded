#!/bin/bash

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/.."

files=()
while IFS=  read -r -d $'\0'; do
    files+=("$REPLY")
done < <(find "$PROJECT_DIR/src" \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' -o -name '*.hh' -o -name '*.hpp' \) -print0)

invalid=""
for file in "${files[@]}"
do
    base_name=$(basename ${file})
    temp_file=$(mktemp /tmp/${base_name}.XXXXXX)
    clang-format -style=file "${file}" > "${temp_file}"
    diff "${file}" "${temp_file}" &> /dev/null
    result=$?
    rm "${temp_file}"
    if [ ${result} != 0 ]; then
        echo "Coding style error in ${file}"
        invalid="${invalid} ${file}"
    fi
done

if [ ! -z "${invalid}"  ]; then
    echo
    echo "Fix all coding style errors by running:"
    echo "clang-format -style=file -i ${invalid}"
    exit 1;
fi
