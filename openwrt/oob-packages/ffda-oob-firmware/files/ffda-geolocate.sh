#!/bin/sh

API_KEY="$(uci get ffda-oob-firmware.geolocator.api_key)"

if [ -z "$API_KEY" ]; then
	echo "No API key found. Please set one in the configuration."
	exit 1
fi

# Get the current location
ip link set dev wlan0 up
clocate -p google -k AIzaSyA6ox6kpT0PXoxepY77xudrhJ9Y9W5Birc
ip link set dev wlan0 down
