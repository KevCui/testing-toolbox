#!/usr/bin/env bash

# HOW TO USE
# ~$ ./caseCovert.sh "<text>"

_WORD_ARR=( $* )

echo -e "\nUpper case:"
echo "$@" | awk '{print toupper($0)}'

echo -e "\nLower case:"
echo "$@" | awk '{print tolower($0)}'

echo -e "\nCapitalized case:"
echo "${_WORD_ARR[@]^}"

echo -e "\nSentence case:"
echo "$@" | sed -r "s/(^|\.\s+)./\U&/g"

echo -e "\nAlternating case:"
sentence=""
for word in "${_WORD_ARR[@]}"; do
    [ $((((RANDOM%10)+1)%2)) -eq 0 ] && tolower=true || tolower=false
    for i in $(seq 1 ${#word}); do
        if $tolower; then
            sentence=${sentence}$(echo "${word:i-1:1}" | awk '{print tolower($0)}')
            tolower=false
        else
            sentence=${sentence}$(echo "${word:i-1:1}" | awk '{print toupper($0)}')
            tolower=true
        fi
    done
    sentence=${sentence}" "
done
echo "$sentence"

echo -e "\nInverse case:"
sentence=""
for word in "${_WORD_ARR[@]}"; do
    for i in $(seq 1 ${#word}); do
        if [[ "${word:i-1:1}" =~ [A-Z] ]]; then
            sentence=${sentence}$(echo "${word:i-1:1}" | awk '{print tolower($0)}')
        else
            sentence=${sentence}$(echo "${word:i-1:1}" | awk '{print toupper($0)}')
        fi
    done
    sentence=${sentence}" "
done
echo "$sentence"
