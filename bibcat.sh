#!/bin/env bash
while read key
do
    readarray -d $'\0' -t matches < <(grep -hozP "(?s)@[^{}]+{$key,[^{}]*(({(?>[^{}]+|(?1))*})*[^{}])+}" $@)
    if [ "${#matches[@]}" = "0" ]
    then
        (>&2 echo "error: $key not found")
    elif [ "${#matches[@]}" = "1" ]
    then
        echo "${matches[@]}"
    else
        mapfile -d $'\0' -t uniq < <(printf "%s\0" "${matches[@]}" | sort -zu)
        if (( ${#uniq[@]} <= 1 )); then
            (>&2 echo "error: $key multiple identical occurences, ignored")
            echo "${uniq[@]}"
            continue
        fi
        (>&2 echo "error: $key multiple occurences, please resolve")
        select match in "${matches[@]}"
        do
            if [ -n "$match" ]
            then
                echo "$match"
                break
            fi
        done < /dev/tty
    fi
done
