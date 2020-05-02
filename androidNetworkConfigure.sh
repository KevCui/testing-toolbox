#!/usr/bin/env bash

#/ Usage:
#    ./androidNetworkConfigure.sh <path_to_AndroidManifest.xml>
#/
#/ Options:
#/   --help: Display this help message

usage() { grep '^#/' "$0" | cut -c4- ; exit 0 ; }
expr "$*" : ".*--help" > /dev/null && usage

_DIR="$1"
_XML="$_DIR/res/xml/network_security_config.xml"
_MANIFEST="$_DIR/AndroidManifest.xml"
_TMP="$_MANIFEST.tmp"

if [ ! -f "$_MANIFEST" ]; then
    echo "File $_MANIFEST doesn't exist!"
    exit 1
fi

if grep -q "networkSecurityConfig" "$_MANIFEST"; then
    echo "File $_MANIFEST has already been modified!"
    exit 1
fi

cp "$_MANIFEST" "$_TMP"
cat "$_TMP" | sed -e "/<application/a\\
android\:networkSecurityConfig=\"@xml\/network_security_config\"" > "$_MANIFEST"
rm "$_TMP"

# Add xml
echo '<?xml version="1.0" encoding="utf-8"?>
<network-security-config>
    <base-config>
        <trust-anchors>
            <certificates src="system" />
            <certificates src="user" />
        </trust-anchors>
    </base-config>
</network-security-config>' > "$_XML"

echo "DONE!"