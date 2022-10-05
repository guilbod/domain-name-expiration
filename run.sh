#!/bin/bash

domains_list="domains.txt"
result="expiration.txt"
skip=""

while read -r line; do
    if test -f "$result"; then #if output file exists
        skip=$(grep "$line" expiration.txt)
    else
        touch $result
    fi

    if [ -n "$skip" ]; then #if domain already scanned (unique domain checker)
        continue
    else
        exp=$(whois "$line" | grep -oE "Registry Expiry Date: ....-..-..T..:..:..*Z" | cut -d " " -f 4)
        total="${line} ${exp}"
        echo "$total" >> $result
    fi
done <$domains_list