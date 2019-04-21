#!/usr/bin/env bash
#
# Call Antideo APIs from terminal to validate IP adress, phone nubmer or Email address
#
#/ Usage:
#/   ./antideo.sh -ilo|-m|-p <ip_addr|phone_num|email_addr>
#/
#/ Options:
#/   IP
#/   -i             Show IP health check result
#/   -l             Show IP location info
#/   -o             Show IP organisation info
#/
#/   Email
#/   -m             Show Email email address check result
#/
#/   Phone
#/   -p             Show phone number check result
#/
#/   -h, --help     Display this help message
#/
#/ Option combinations:
#/   -i, -il, -io, -l, -lo, -o, -ilo, -p , -m

usage() {
    # Display usage message
    grep '^#/' "$0" | cut -c4-
    exit 0
}

set_api_var() {
    # Declare variables used in script
    _HOST="https://api.antideo.com"
    _URL_IP_HEALTH="${_HOST}/ip/health"
    _URL_IP_ORGANISATION="${_HOST}/ip/info"
    _URL_IP_LOCATION="${_HOST}/ip/location"
    _URL_EMAIL_INFO="${_HOST}/email"
    _URL_PHONE_INFO="${_HOST}/phone"
}

get_args() {
    # Declare arguments
    expr "$*" : ".*--help" > /dev/null && usage
    while getopts ":hilomp" opt; do
        case $opt in
            i)
                _SHOW_IP_HEALTH=true
                ;;
            l)
                _SHOW_IP_LOCATION=true
                ;;
            o)
                _SHOW_IP_ORGANISATION=true
                ;;
            m)
                _SHOW_EMAIL_INFO=true
                ;;
            p)
                _SHOW_PHONE_INFO=true
                ;;
            h)
                usage
                ;;
            \?)
                echo "Invalid option: -$OPTARG" >&2
                usage
                ;;
        esac
    done
    shift $((OPTIND-1))
    _INPUT="$*"
}

check_command() {
    # Check if required command exists
    _CURL=$(command -v curl)
    if [[ ! "$_CURL" ]]; then
        echo "'curl' command dosen't exist!" && exit 1
    fi

    _JQ=$(command -v jq)
    if [[ ! "$_JQ" ]]; then
        echo "'jq' command dosen't exist!" && exit 1
    fi
}

check_args() {
    # Check event uuid and auth token are set
    [[ $(echo "${_SHOW_IP_HEALTH}${_SHOW_IP_LOCATION}${_SHOW_IP_ORGANISATION}" | grep -o "true" | wc -l) -eq "0" ]] && ipgroup=false || ipgroup=true
    if [[ ! "$(echo "${ipgroup}${_SHOW_PHONE_INFO}${_SHOW_EMAIL_INFO}" | grep -o "true" | wc -l)" -eq "1" ]]; then
        echo "Wrong option!"
        usage
    fi
    if [[ -z "$_INPUT" && $ipgroup == false ]]; then
        echo "Input IP address or Phone number or Email address is missing!"
        usage
    fi
}

call() {
    # Call API, $1: endpoint URL
    $_CURL -sSX GET "$1" -H 'cache-control: no-cache' | $_JQ .
}

main() {
    check_command
    get_args "$@"
    check_args
    set_api_var
    [[ "$_SHOW_IP_HEALTH" ]] && call "$_URL_IP_HEALTH/$_INPUT"
    [[ "$_SHOW_IP_LOCATION" ]] && call "$_URL_IP_LOCATION/$_INPUT"
    [[ "$_SHOW_IP_ORGANISATION" ]] && call "$_URL_IP_ORGANISATION/$_INPUT"
    [[ "$_SHOW_PHONE_INFO" ]] && call "$_URL_PHONE_INFO/$_INPUT"
    [[ "$_SHOW_EMAIL_INFO" ]] && call "$_URL_EMAIL_INFO/$_INPUT"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi
