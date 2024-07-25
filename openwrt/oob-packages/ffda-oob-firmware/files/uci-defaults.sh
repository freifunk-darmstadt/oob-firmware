#!/bin/sh

# Always overwrite authorized_keys
cp /lib/ffda-oob-firmware/conffiles/authorized_keys /etc/dropbear/authorized_keys

# Check if /lib/ffda-oob-firmware/configured exists
if [ -f /lib/ffda-oob-firmware/configured ]; then
    exit 0
fi

# Copy th default configuration files
cp /lib/ffda-oob-firmware/conffiles/config/* /etc/config/

# ToDo: Randomize host-id for state-reporter

# ToDo: Set hostname to "ffda-oob-<host-id>"

# Mark device as configured
touch /lib/ffda-oob-firmware/configured

exit 0