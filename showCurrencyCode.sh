#!/usr/bin/env bash

#/ Usage:
#/   ./showCurrencyCode.sh | grep -i "<search_keyword>"

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

if [[ -z $(command -v hxselect) || -z $(command -v hxnormalize) ]]; then
    echo "Please install html-xml-utils https://www.w3.org/Tools/HTML-XML-utils/README"
    exit 1
fi

_URL="https://www.iban.com/currency-codes"
i=1
for line in $(curl -Ss "$_URL"| hxnormalize -x | hxselect -c 'tbody' -c 'tr' | grep '<td>' | sed -e 's/ /_/g'); do

    if [ "$((i%4))" -eq "0" ]; then
        echo "$_PART1 $_PART2 $_PART3"
        i=0
        for n in {1..3}; do
            declare _PART$n=""
        done
    else
        declare _PART$i="$(echo "$line" | sed -e 's/.*<td>//' -e 's/<\/td>$//')"
    fi

    i=$((i+1))
done
