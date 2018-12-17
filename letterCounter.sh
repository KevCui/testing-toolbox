#!/usr/bin/env bash

# HOW TO USE:
# ~$ ./letterCounter.sh '<text>'

_STR_VAR="$*"
_WORDS=("${_STR_VAR//,/ }")

echo "Character: ${#_STR_VAR}"
echo "Word: $(echo "${_WORDS[@]}" | wc -w)"
