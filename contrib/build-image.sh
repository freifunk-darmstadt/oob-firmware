#!/bin/bash

EXTRA_PKGS="kmod-usb-serial-pl2303 kmod-usb-serial-cp210x kmod-usb-serial-ftdi luci luci-proto-qmi picocom gl-puli-mcu kmod-usb-serial-option qmi-utils ffda-oob-firmware"

make image PROFILE="glinet_gl-xe300" PACKAGES="$EXTRA_PKGS"