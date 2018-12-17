#!/usr/bin/env bash

# HOW TO USE:
# ~$ ./uuidValidator.sh '<text>'
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
