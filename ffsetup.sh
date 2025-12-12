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
printf "\nStarting Firefox...\n"

# Run Firefox headless to generate a profile
$ff --headless >/dev/null 2>&1 &
sleep 3
pkill "$ff"

# Grab profile
profile="$HOME/.mozilla/firefox/$(grep "Default=.*\.default-release" $HOME/.mozilla/firefox/profiles.ini | sed "s/Default=//")"
[ ! -d "$profile" ] && die "Could not create/fetch Firefox profile"

# Install Arkenfox user.js
echo "Installing Arkenfox and custom user.js..."
curl -sL "https://raw.githubusercontent.com/arkenfox/user.js/master/user.js" > "$profile/user.js"

# Add extra settings to user.js
curl -sL "https://git.sr.ht/~bpv/ffsetup/blob/master/extra.js" >> "$profile/user.js"

# Create Firefox policies directory and put policies.json in it
echo "Installing polcies.json..."
[ ! -d "/etc/firefox/policies" ] && su -c "mkdir -p /etc/firefox/policies"

echo "Please enter password to install policies.json system-wide:"
su -c "cp policies.json /etc/firefox/policies/"

echo "Done!"
