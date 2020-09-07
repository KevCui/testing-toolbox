#!/usr/bin/env bash

#/ Usage:
#/   ./jwtDecoder.sh "<JWT token>"
#/
#/ Options:
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }

padding() {
    # $1: base64 string
    local m p=""
    m=$(( ${#1} % 4 ))
    [[ "$m" == 2 ]] && p="=="
    [[ "$m" == 3 ]] && p="="
    echo "${1}${p}"
}

expr "$*" : ".*--help" > /dev/null && usage

if [[ -z $(command -v jq) ]]; then
    echo "This script will NOT work on your machine."
    echo "Please install jq first: https://stedolan.github.io/jq/download/"
    exit 1
fi

clear
input=("${@}")
input=("${input//$'\n'/}")
input=("${input//' '/}")
token=$(IFS=$'\n'; echo "${input[*]}")

echo "JWT token: ${token}"
IFS='.' read -ra ADDR <<< "$token"
base64 -d <<< "$(padding "${ADDR[0]}")" | jq
base64 -d <<< "$(padding "${ADDR[1]}")" | jq
echo "Signature: ${ADDR[2]}"