#!/usr/bin/env bash

# HOW TO USE
# ~$ ./androidNetworkConfigure.sh <path_to_AndroidManifest.xml>

_ROOT="$1"
_DIR="$_ROOT/android/src/main/"
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
        </trust-anchors>
    </base-config>
    <debug-overrides>
        <trust-anchors>
            <certificates src="user" />
        </trust-anchors>
    </debug-overrides>
</network-security-config>' > "$_XML"

echo "DONE!"