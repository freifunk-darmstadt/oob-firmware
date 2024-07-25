#!/bin/bash

EXTRA_PKGS="\
	ffda-oob-firmware \
	kmod-usb-serial-cp210x \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-option \
	kmod-usb-serial-pl2303 \
	picocom gl-puli-mcu \
	qmi-utils \
"

make image PROFILE="glinet_gl-xe300" PACKAGES="$EXTRA_PKGS"