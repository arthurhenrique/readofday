#!/bin/bash

declare -A bible_books
bible_books["sl"]="5" # 130 cap / 30 day of month
bible_books["ap"]="1" #  22 cap / 30 day of month
bible_books["pv"]="1" #  31 cap / 30 day of month

BIBLE_BOOK="pv"

mkdir -p bible/$BIBLE_BOOK
mkdir -p bible/reads

div=${bible_books[$BIBLE_BOOK]}
day=$(date "+%d" | sed 's/^0//')

start=$(echo $(($day * $div - $div)))
end=$(echo $(($day * $div)))
for i in $(seq  $start $end); do
    curl -Ss https://www.abibliadigital.com.br/api/verses/acf/$BIBLE_BOOK/$i | \
    jq '.verses[].text' | \
    sed 's/\"//g' > bible/$BIBLE_BOOK/$i

    echo "" >> "bible/reads/day_$(date "+%d_%m_%Y")"
    echo "$BIBLE_BOOK - $i" >> "bible/reads/day_$(date "+%d_%m_%Y")"
    cat bible/$BIBLE_BOOK/$i >> "bible/reads/day_$(date "+%d_%m_%Y")"
 done

cat bible/reads/day_$(date "+%d_%m_%Y") > bible/reads/today

echo "# Read of day" > README.md
echo "" >> README.md
echo "- [$BIBLE_BOOK ($start - $end)](bible/reads/today)" >> README.md
