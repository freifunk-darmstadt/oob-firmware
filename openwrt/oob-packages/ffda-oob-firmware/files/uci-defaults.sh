#!/bin/sh

PREVIOUS_FIRMWARE_VERSION="$(cat /lib/ffda-oob-firmware/configured)"
CURRENT_FIRMWARE_VERSION="$(cat /lib/ffda-oob-firmware/firmware-version)"
FIRSTBOOT="1"

# Always overwrite authorized_keys
cp /lib/ffda-oob-firmware/conffiles/authorized_keys /etc/dropbear/authorized_keys

# Copy banner
cp /lib/ffda-oob-firmware/banner.txt /etc/banner

# Replace %VERSION% in banner with current version
sed -i "s/%VERSION%/${CURRENT_FIRMWARE_VERSION}/" /etc/banner

# Check if /lib/ffda-oob-firmware/configured exists
if [ -f "/lib/ffda-oob-firmware/configured" ]; then
	echo "Device has already been configured."
	FIRSTBOOT="0"
fi

# Mark device as configured
echo "$CURRENT_FIRMWARE_VERSION" > /lib/ffda-oob-firmware/configured

# Check if this is the first boot
if [ "$FIRSTBOOT" -eq "0" ]; then
	exit 1
fi

# Copy th default configuration files
cp /lib/ffda-oob-firmware/conffiles/config/* /etc/config/

# Get label-mac
LABEL_MAC="$(/lib/ffda-oob-firmware/label-mac.sh)"

# Remove colons
LABEL_MAC_NO_COLONS="$(echo $LABEL_MAC | tr -d ':')"

# Hash label-mac
LABEL_MAC_HASH="$(echo $LABEL_MAC | sha256sum | cut -c1-8)"

# Convert to decimal
HOST_ID="$(printf "%d" 0x$LABEL_MAC_HASH)"

# Host ID is 1024 - 65000
HOST_ID="$((HOST_ID + 1024))"
HOST_ID="$((HOST_ID % 65000))"

# Set Host-ID as reporter_id
uci set ffda-oob-state-reporter.core.reporter_id="$HOST_ID"
uci commit ffda-oob-state-reporter

# Set default hostname
uci set system.@system[0].hostname="ffda-oob-$LABEL_MAC_NO_COLONS"

# Add reboot-cronjob after 24 hours
echo "0 */24 * * *	/sbin/reboot" > /etc/crontabs/root

# Lock root-user account
passwd -l root

exit 0