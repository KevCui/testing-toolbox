#!/usr/bin/env bash

#/ Usage:
#/   ./loremGenerator.sh -p <paragraph_num> -l <max_line_length>
#/
#/ Options:
#/   -p:    number of paragraphs, default 5
#/   -l:    maximum number of char per line, default 64
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

if [[ -z $(command -v hxselect) || -z $(command -v hxnormalize) ]]; then
    echo "Please install html-xml-utils https://www.w3.org/Tools/HTML-XML-utils/README"
    exit 1
fi

_HXSELECT=$(command -v hxselect)
_HXNORMALIZE=$(command -v hxnormalize)
_CURL=$(command -v curl)
_PARAGRAPH_NUM=5
_MAX_LINE_LENGTH=64
_OUTPUT_CLASS='.anyipsum-output p'

while getopts ":p:l:" opt; do
    case $opt in
        p)
            _PARAGRAPH_NUM="$OPTARG"
            ;;
        l)
            _MAX_LINE_LENGTH="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

_URL="https://hipsum.co/?paras=$_PARAGRAPH_NUM&type=hipster-latin&start-with-lorem=1"

$_CURL -Ss "$_URL" | $_HXNORMALIZE -x -i 0 -l "$_MAX_LINE_LENGTH" | $_HXSELECT -c -s '\n' "$_OUTPUT_CLASS"
