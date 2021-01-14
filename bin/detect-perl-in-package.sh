#!/bin/bash

source /usr/share/makepkg/util/message.sh

finder() {
    while IFS= read -rd '' file; do
        if objdump -p "$file" 2>/dev/null | grep -qE "NEEDED\s+libperl.so"; then
            return 0 # links to libperl
        fi
        if [[ $(head -c2 "$file" | tr -d '\0') = '#!' ]]; then # script
            if grep -q '\bperl\b' "$file"; then
                return 0 # executes perl binary
            fi
        fi
    done
    return 1
}

clean_up() {
    if [[ -d "$workdir" ]]; then
        rm -rf "$workdir"
    fi
}
trap 'clean_up' EXIT

if [[ -f "$1" ]]; then
    pkgfile="$1"
else
    pkgfile_remote="$(pacman -Sddp "$1" 2>/dev/null)" || { error "package name '$1' not in repos"; exit 1; }
    pkgfile="${pkgfile_remote#file://}"
    if [[ ! -f "$pkgfile" ]]; then
        msg "Downloading package '%s' into pacman's cache" "$1"
        sudo pacman -Swdd --logfile /dev/null "$1" || exit 1
        pkgfile_remote="$(pacman -Sddp "$1" 2>/dev/null)"
        pkgfile="${pkgfile_remote#file://}"
    fi
fi

workdir="$(mktemp -d)"
bsdtar xf "$pkgfile" -C "$workdir"
find "$workdir" -type f -print0 | sort -z | finder
