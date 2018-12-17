#!/usr/bin/env bash

# HOW TO USE:
# ~$ ./generateFile.sh -o <character_option> -l <name_length> -e <file_extension> -s <file_size>"
#
# Example:
# 1. Generate a 128k txt file, file name contains only numbers:
#    ~$ ./generateFile.sh -o "0-9" -e ".txt" -s 128k
#
# 2. Generate a jpg file, flie name has 12 characters:
#    ~$ ./generateFile.sh -l 12 -e ".jpg"
#
# 3. Generate a 5m mp4 file, flie name has 8 characters, contains capital letters:
#    ~$ ./generateFile.sh -o "A-Z" -l 8 -e ".mp4" -s 5m

_NAME_OPTION='a-zA-Z0-9_'
_FILE_ECTENTION=''
_NAME_LENGTH=16
_FILE_SIZE='64k'

print_help() {
    echo "Usage: generateFile.sh -o <character_option> -l <name_length> -e <file_extension> -s <file_size>"
}

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
            print_help
            ;;
    esac
done

_FILE=$(< /dev/urandom tr -cd "$_NAME_OPTION" | head -c "$_NAME_LENGTH")"$_FILE_ECTENTION"

fallocate -l "$_FILE_SIZE" "$_FILE"
