#!/bin/bash

source /usr/share/makepkg/util/message.sh
colorize

extension=$1
filename=$2
shift 2

case $1 in
    raw)
        all_versions=/dev/null
        show_ver() { printf '%s-%s\n' "$version" "$file"; }
        ;;
    *)
        all_versions=/dev/stderr
        show_ver() {
            msg2 "pkgver=$version" 2>&1
            msg2 "_file=$file" 2>&1
        }
        ;;
esac

download_url=$(curl "https://addons.mozilla.org/api/v3/addons/addon/$extension/"| jq -r '.current_version.files | .[].url')
file="$(echo "$download_url"|sed -r 's@.*file/([0-9]+)/.*@\1@g')"
version="$(echo "$download_url"|sed -r 's@.*'$filename'-([0-9.]+)-.*@\1@g')"

show_ver

if echo "$download_url"|grep -qs data-realurl; then
    error "$extension not yet reviewed"
fi
