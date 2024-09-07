#!/bin/sh

# Firefox Setup Script

die() {
	# Print error and exit
	printf "%s\n" "$1" >&2
	exit 1
}

# Check if script is run as root
[ "$(id -u)" -eq 0 ] && die "Do NOT run script as root!"

if which firefox >/dev/null 2>&1; then
	ff=firefox
elif which firefox-esr >/dev/null 2>&1; then
	ff=firefox-esr
else
	die "Firefox is not installed!"
fi

echo "ffsetup - A Firefox setup script"
echo "Written by Bryce Vandegrift <https://brycevandegrift.xyz>"
echo "\nStarting Firefox..."

# Run Firefox headless to generate a profile
$ff --headless >/dev/null 2>&1 &
sleep 3
pkill "$ff"

# Grab profile
profile="$HOME/.mozilla/firefox/$(grep "Default=.*\.default-release" $HOME/.mozilla/firefox/profiles.ini | sed "s/Default=//")"
[ ! -d "$profile" ] && die "Could not create/fetch Firefox profile"

# Install Arkenfox user.js
echo "Installing Arkenfox user.js..."
curl -sL "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" > "$profile/user.js"

# Add extra settings to user.js
curl -sL "https://git.sr.ht/~bpv/ffsetup/blob/master/extra.js" >> "$profile/user.js"

# Create temp directory
tempff="$(mktemp -d)"
trap "rm -rf $tempff" HUP INT QUIT TERM PWR EXIT

# Install extensions
echo "Installing browser extensions..."
extensions="ublock-origin decentraleyes clearurls privacy-redirect"
IFS=' '
mkdir "$profile/extensions/"
for x in $extensions; do
	extensionurl="$(curl -sL "https://addons.mozilla.org/en-US/firefox/addon/${x}/" | grep -o 'https://addons.mozilla.org/firefox/downloads/file/[^"]*')"
	file="${extensionurl##*/}"
	curl -sL "$extensionurl" > "$tempff/$file"
	id="$(unzip -p "$tempff/$file" manifest.json | grep "\"id\"")"
	id="${id%\"*}"
	id="${id##*\"}"
	mv "$tempff/$file" "$profile/extensions/$id.xpi" || die "Could not install an extension correctly"
done

# Enable extensions
echo "Enabling extensions..."
# Generate extensions.json
$ff --headless >/dev/null 2>&1 &
sleep 10
pkill "$ff"

# Edit prefs to enable extensions
sed -i 's/\(seen":\)false/\1true/g; s/\(active":\)false\(,"userDisabled":\)true/\1true\2false/g' "$profile/extensions.json"
sed -i 's/\(extensions\.pendingOperations", \)false/\1true/' "$profile/prefs.js"

# Change default search engine (for x86_64)
arch="$(uname -m)"
if [ $arch == "x86_64" ]; then
	echo "Downloading mozlz4 temporarily..."
	curl -sL "https://github.com/BryceVandegrift/ffsetup/releases/download/v0.1/mozlz4.xz" > "$tempff/mozlz4.xz"
	xz -d "$tempff/mozlz4.xz"
	chmod +x "$tempff/mozlz4"
	echo "Changing default search engine..."
	$tempff/mozlz4 "$profile/search.json.mozlz4" | sed 's/{}/{"hidden":true}/; s/\(Bing[^{]*{\)/\1"hidden":true/' > "$tempff/search.json"
	$tempff/mozlz4 -z "$tempff/search.json" > "$profile/search.json.mozlz4"
else
	echo "Skipping search engine change..."
fi

echo "Done!"
