#!/bin/bash

shopt -s extglob

cd /var/cache/pacman/custom

act="add"
force="-n"

while [[ "${1}" != "" ]]; do
    case "${1}" in
        -r|--remove)
            act="remove"
            ;;
        -f|--force)
            force=""
            ;;
        -k|--kernel)
            upgrade_kernels=1
            ;;
        *)
            break
            ;;
    esac
    shift
done

if [[ "${1}" != "" ]]; then
    while [[ "${1}" != "" ]]; do
        if [[ "${act}" = "remove" ]]; then
            packages+=("${1}")
        else
            packages+=(${1}-+([a-z0-9.:_+])-[0-9.]-@(any|x86_64).pkg.tar.xz)
        fi
        shift
    done
else
    packages=(*.pkg.tar.xz)
fi

mapfile -td '' spackages < <(printf "%s\0" "${packages[@]}"|pacsort -zf)

for pkg in "${spackages[@]}"; do
    if [[ ${pkg} =~ ^linux-?.* ]]; then
        kernel_pkgs+=("${pkg}")
    else
        regular_pkgs+=("${pkg}")
    fi
done

if [[ "${upgrade_kernels}" != "" ]]; then
    repo-${act} ${force} custom.db.tar.gz ${kernel_pkgs[@]}
else
    repo-${act} -R ${force} custom.db.tar.gz ${regular_pkgs[@]}
fi
