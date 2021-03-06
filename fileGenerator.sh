#!/usr/bin/env bash

#/ Usage:
#/   ./fileGenerator.sh -o <character_option> -l <name_length> -e <file_extension> -s <file_size>"
#/
#/ Options:
#/   -o:     regex of available characters, default [a-zA-Z0-9_]
#/   -l:     length of file name, default 16 characters
#/   -e:     file extension
#/   -s:     file size, default 64k
#/   --help: Display this help message
#/
#/ Examples:
#/   1. Generate a 128k txt file, file name contains only numbers:
#/      ~$ ./fileGenerator.sh -o "0-9" -e ".txt" -s 128k
#/
#/   2. Generate a jpg file, flie name has 12 characters:
#/      ~$ ./fileGenerator.sh -l 12 -e ".jpg"
#/
#/   3. Generate a 5m mp4 file, flie name has 8 characters, contains capital letters:
#/      ~$ ./fileGenerator.sh -o "A-Z" -l 8 -e ".mp4" -s 5m

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

_NAME_OPTION='a-zA-Z0-9_'
_FILE_ECTENTION=''
_NAME_LENGTH=16
_FILE_SIZE='64k'

while getopts ":o:l:e:s:" opt; do
    case $opt in
        o)
            _NAME_OPTION="$OPTARG"
            ;;
        l)
            _NAME_LENGTH="$OPTARG"
            ;;
        e)
            _FILE_ECTENTION="$OPTARG"
            ;;
        s)
            _FILE_SIZE="$OPTARG"
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            usage
            ;;
    esac
done

_FILE=$(< /dev/urandom tr -cd "$_NAME_OPTION" | head -c "$_NAME_LENGTH")"$_FILE_ECTENTION"

fallocate -l "$_FILE_SIZE" "$_FILE"
