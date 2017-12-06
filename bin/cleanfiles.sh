#!/bin/bash

declare -a finddirs files

while [[ "$1" != "" ]]; do
    [[ -d "$1" ]] && finddirs+=("$1") || files+=("$1")
    shift
done

if (( "${#finddirs[@]}" > 0 )); then
    mapfile -td '' -O "${#files[@]}" files < <(
        find "${finddirs[@]}" -regextype egrep \
        -regex '.*\.(py|txt|html?|(c|h)(pp)?|md|ini)' -print0)
fi

sed --follow-symlinks -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' -e 's/[[:space:]]\+$//' "${files[@]}"
