#!/usr/bin/env bash

#/ Usage:
#/   ./uuidValidator.sh '<text>'
#/
#/ Options:
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage
#
# command to generate a valid UUID: uuidgen

_UUID="$*"
_UUID="${_UUID/\{/}"
_UUID="${_UUID/\}/}"

if [[ "$_UUID" != *"-"* ]]; then
    _UUID=${_UUID:0:8}-${_UUID:8:4}-${_UUID:12:4}-${_UUID:16:4}-${_UUID:20}
fi

echo "$_UUID"
[[ "$_UUID" =~ ^\{?[A-F0-9a-f]{8}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{4}-[A-F0-9a-f]{12}\}?$ ]] && echo "true" || echo "false"
