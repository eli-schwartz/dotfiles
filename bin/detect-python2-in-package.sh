#!/bin/bash

source /usr/share/makepkg/util/message.sh
colorize

VERBOSE=0

log() {
    if (( VERBOSE )); then
        printf '  -> %s\n%s\n\n' "$1" "$2"
        return 0
    else
        return 1
    fi
}

finder() {
    local ret=1 res
    while IFS= read -rd '' file; do
        #echo "debug: processing ${file#$workdir}"
        if res=$(objdump -p "$file" 2>/dev/null | grep -E "NEEDED\s+libpython2.7.so"); then
            ret=0 # links to libpython
            #echo "debug: logging ${file#$workdir}"
            log "${file#$workdir}" "$res" || return $ret
        elif [[ $(head -c2 "$file" | tr -d '\0') = '#!' ]]; then # script
            if res=$(grep '\bpython2\b' "$file"); then
                ret=0 # executes python2 binary
                #echo "debug: logging ${file#$workdir}"
                log "${file#$workdir}" "$res" || return $ret
            fi
        fi
    done
    return $ret
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
    pkgfile_remote="$(pacman -Sddp "$1" 2>/dev/null)" || { error "package name not in repos"; exit 1; }
    pkgfile="${pkgfile_remote#file://}"
    if [[ ! -f "$pkgfile" ]]; then
        msg "Downloading package '%s' into pacman's cache" "$1"
        sudo pacman -Swdd --logfile /dev/null "$1" || exit 1
        pkgfile_remote="$(pacman -Sddp "$1" 2>/dev/null)"
        pkgfile="${pkgfile_remote#file://}"
    fi
fi

if [[ $2 = verbose ]]; then
    VERBOSE=1
fi

workdir="$(mktemp -d)"
bsdtar xf "$pkgfile" -C "$workdir"
find "$workdir" -type f -print0 | sort -z | finder
