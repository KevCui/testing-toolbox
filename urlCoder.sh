#!/usr/bin/env bash

#/ Usage:
#/ 1. Encode URL
#/    ./urlCoder.sh '<URL>'
#/
#/ 2. Decode URL
#/    ./urlCoder.sh -d '<URL>'
#/
#/ Options:
#/   -d:     Decode URL
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

print_help() {
    echo "Encode usage: urlCoder.sh <URL>"
    echo "Decode usage: urlCoder.sh -d <URL>"
}

while getopts ":d:" opt; do
    case $opt in
        d)
            _DECODE_URL="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            print_help
            ;;
    esac
done

if [ -n "$_DECODE_URL" ]; then
    python3 -c "import sys, urllib.parse as ul; print(ul.unquote(sys.argv[1]))" "$_DECODE_URL"
else
    python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(sys.argv[1]))" "$@"
fi
