#!/usr/bin/env bash

# HOW TO USE:
# ~$ chmod +x jwtDecoder.sh
# ~$ ./jwtDecoder.sh "<JWT token>"

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

echo -e "JWT token:\\n${token}"

IFS='.' read -ra ADDR <<< "$token"
for i in "${ADDR[@]}"; do
    echo "$i" | base64 -d 2> /dev/null | jq '.' 2> /dev/null
done