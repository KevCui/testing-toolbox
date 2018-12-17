#!/usr/bin/env bash

# HOW TO USE
# ~$ ./caseCovert.sh -t "<text>" -aAcCis
#
# Covert options:
#  -a     lower case
#  -A     upper case
#  -C     capitalized case
#  -c     alternating case
#  -s     sentence case
#  -i     inverse case

while getopts ":aAicCst:" opt; do
    case $opt in
        A)
            _UPPER_CASE=true
            _PARAM=true
            ;;
        a)
            _LOWER_CASE=true
            _PARAM=true
            ;;
        C)
            _CAPITALIZED_CASE=true
            _PARAM=true
            ;;
        c)
            _ALTERNATING_CASE=true
            _PARAM=true
            ;;
        s)
            _SENTENCE_CASE=true
            _PARAM=true
            ;;
        i)
            _INVERSE_CASE=true
            _PARAM=true
            ;;
        t)
            _WORD="$OPTARG"
            _WORD_ARR=( $OPTARG )
            ;;
        *)
            ;;
    esac
done

if [ -z "$_PARAM" ]; then
    echo "Options are missing:"
    echo "  -t      <text>"
    echo "  -a      ower case"
    echo "  -a      lower case"
    echo "  -A      upper case"
    echo "  -C      capitalized case"
    echo "  -c      alternating case"
    echo "  -s      sentence case"
    echo "  -i      inverse case"
    echo -e "\nUsage: caseCovert.sh -t <text> -aAcCis"
fi

if [ -n "$_UPPER_CASE" ]; then
    echo -e "\nUpper case:"
    echo "$_WORD" | awk '{print toupper($0)}'
fi

if [ -n "$_LOWER_CASE" ]; then
    echo -e "\nLower case:"
    echo "$_WORD" | awk '{print tolower($0)}'
fi

if [ -n "$_CAPITALIZED_CASE" ]; then
    echo -e "\nCapitalized case:"
    echo "${_WORD_ARR[@]^}"
fi

if [ -n "$_SENTENCE_CASE" ]; then
    echo -e "\nSentence case:"
    echo "$_WORD" | sed -r "s/(^|\.\s+)./\U&/g"
fi

if [ -n "$_ALTERNATING_CASE" ]; then
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
fi

if [ -n "$_INVERSE_CASE" ]; then
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
fi
