#!/usr/bin/env bash

#/ Usage:
#/   ./letterCounter.sh '<text>'
#/
#/ Options:
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

_STR_VAR="$*"
_WORDS=("${_STR_VAR//,/ }")

echo "Character: ${#_STR_VAR}"
echo "Word: $(echo "${_WORDS[@]}" | wc -w)"
