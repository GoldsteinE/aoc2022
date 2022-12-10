#!/bin/sh

set -e

current_directory='_'
fsize__=0

while read -r command; do
    case "$command" in
        '$ cd /')
            current_directory='_'
            ;;
        '$ cd ..')
            current_directory="${current_directory%_*}"
            ;;
        '$ ls')
            ;;
        '$ cd '*)
            directory="${command#'$ cd '}"
            current_directory="${current_directory}_${directory}"
            ;;
        'dir '*)
            ;;
        *)
            size="${command% *}"
            parent="$current_directory"
            while [ "$parent" != "_" ]; do
                eval "test -z \"\$fsize_${parent}\" && fsize_${parent}=0 ||:"
                eval "fsize_${parent}=\$((fsize_${parent} + $size))"
                parent="${parent%_*}"
            done
            eval "fsize__=\$((fsize__ + ${size}))"
            ;;
    esac
done

set | {
    total_fs_size=70000000
    required_unused=30000000
    current_unused="$(( total_fs_size - fsize__))"
    min_delete="$(( required_unused - current_unused ))"

    total=0
    min_found=inf
    while read -r variable; do
        var_name="${variable%=*}"
        var_value="${variable#*=}"
        case "$var_name" in
            fsize_*)
                if [ "$var_value" -le 100000 ]; then
                    total="$(( total + var_value ))"
                fi
                if [ "$var_value" -ge "$min_delete" ]; then
                    if [ "$min_found" = "inf" ] || [ "$var_value" -lt "$min_found" ]; then
                        min_found="${var_value}"
                    fi
                fi
                ;;
            *)
                ;;
        esac
    done

    if [ "$1" = 1 ]; then
        printf '%s\n' "$total"
    else
        printf '%s\n' "$min_found"
    fi
}
