#!/bin/bash

declare -A bible_books
bible_books["sl"]="5" # 130 cap / 30 day of month

BIBLE_BOOK="sl"

mkdir -p bible/$BIBLE_BOOK

div=${bible_books[$BIBLE_BOOK]}

seq $(($(date "+%d") * $div - $div)) $(($(date "+%d") * $div)) | \
xargs -I@ curl -Ss https://www.abibliadigital.com.br/api/verses/acf/$BIBLE_BOOK/@ | \
jq '.verses[].text' > bible/$BIBLE_BOOK/day_$(date "+%d")

echo "- [$BIBLE_BOOK day_$(date "+%d")](bible/$BIBLE_BOOK/day_$(date "+%d"))" >> README.md