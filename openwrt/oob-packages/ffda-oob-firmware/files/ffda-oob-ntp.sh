#!/bin/sh

ntpd -n -q -p time.windows.com || exit 1

mkdir -p /tmp/ffda-oob-firmware
date "+%s" > /tmp/ffda-oob-firmware/ntp_last_sync
