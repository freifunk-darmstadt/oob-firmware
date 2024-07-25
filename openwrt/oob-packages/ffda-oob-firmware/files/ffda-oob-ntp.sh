#!/bin/sh

ntpd -n -q -p time.windows.com || exit 1

date "+%s" > /tmp/ntp_last_sync
