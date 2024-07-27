#!/bin/bash

REMOVE_PKGS="\
	-dnsmasq \
	-odhcpd-ipv6only \
	-odhcp6c \
	-ppp \
	-ppp-mod-pppoe \
	-uboot-envtools \
	-wpad-basic-mbedtls \
"


EXTRA_PKGS="\
	clocate \
	ffda-oob-firmware \
	kmod-usb-serial-cp210x \
	kmod-usb-serial-ftdi \
	kmod-usb-serial-option \
	kmod-usb-serial-pl2303 \
	picocom gl-puli-mcu \
	qmi-utils \
	telnet-bsd \
	wpad-mbedtls \
"

make image PROFILE="glinet_gl-xe300" PACKAGES="$REMOVE_PKGS $EXTRA_PKGS"