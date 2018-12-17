#!/usr/bin/env bash

# HOW TO USE:
# ~$ ./urlCoder.sh '<URL_link>'

echo -e "\nEncoded data:"
python3 -c "import sys, urllib.parse as ul; print(ul.quote_plus(ul.quote_plus(sys.argv[1])))" "$@"

echo -e "\nDecoded data:"
python3 -c "import sys, urllib.parse as ul; print(ul.unquote(ul.unquote(sys.argv[1])))" "$@"
