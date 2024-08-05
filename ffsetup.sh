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

# Run Firefox headless to generate a profile
$ff --headless >/dev/null 2>&1 &
trap "pkill $ff" HUP INT QUIT TERM PWR EXIT

# Grab profile
profile="$HOME/.mozilla/firefox/$(grep "Default=.*\.default-release" $HOME/.mozilla/firefox/profiles.ini | sed "s/Default=//")"
[ ! -d "$profile" ] && die "Could not create/fetch Firefox profile"

# Install Arkenfox user.js
curl -sL "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" > "$profile"
