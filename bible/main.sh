#!/bin/bash

declare -A bible_books
bible_books["sl"]="5" # 130 cap / 30 day of month

BIBLE_BOOK="sl"

mkdir -p bible/$BIBLE_BOOK
mkdir -p bible/reads

div=${bible_books[$BIBLE_BOOK]}

for i in $(seq $(($(date "+%d") * $div - $div)) $(($(date "+%d") * $div))); do
    curl -Ss https://www.abibliadigital.com.br/api/verses/acf/$BIBLE_BOOK/$i | \
    jq '.verses[].text' | \
    sed 's/\"//g' > bible/$BIBLE_BOOK/$i

    echo "" >> "bible/reads/day_$(date "+%d_%m_%Y")"
    echo "$BIBLE_BOOK - $i" >> "bible/reads/day_$(date "+%d_%m_%Y")"
    cat bible/$BIBLE_BOOK/$i >> "bible/reads/day_$(date "+%d_%m_%Y")"
 done


echo "- [$BIBLE_BOOK day_$(date "+%d_%m_%Y")](bible/reads/day_$(date "+%d_%m_%Y"))" >> README.md