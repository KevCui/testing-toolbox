#!/usr/bin/env bash

#/ Precondition:
#    Get access_key from https://numverify.com

#/ Usage:
#/   export NUMVERIFY_KEY='<your-access-key>'
#/
#/   1. Query a phone number:
#/     ./phoneNumVerifier.sh <number>
#/
#/   2. List country codes:
#/     ./phoneNumVerifier.sh
#/
#/ Options:
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

if [[ -z $(command -v jq) ]]; then
    echo "This script will NOT work on your machine."
    echo "Please install jq first: https://stedolan.github.io/jq/download/"
    exit 1
fi

clear

_HOST='http://apilayer.net/api'
_KEY="$NUMVERIFY_KEY"
_NUMBER="$*"

if [[ -z "$_NUMBER" ]]; then
    _URL="${_HOST}/countries?access_key=${_KEY}&format=1"
else
    _URL="${_HOST}/validate?access_key=${_KEY}&number=${_NUMBER}&format=1"
fi

echo "$_URL"
curl -sS "$_URL" | jq . 2> /dev/null
