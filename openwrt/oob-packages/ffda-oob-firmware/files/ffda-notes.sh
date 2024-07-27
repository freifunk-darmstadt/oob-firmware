#!/bin/sh

COMMAND="$1"
NOTES_LOCATION="/lib/ffda-oob-firmware/userdata/notes.txt"

if [ -z "$COMMAND" ]; then
	COMMAND="show"
fi

if [ "$COMMAND" == "show" ]; then
	if [ -f "$NOTES_LOCATION" ]; then
		cat "$NOTES_LOCATION"
	else
		echo "No notes available"
	fi
elif [ "$COMMAND" == "edit" ]; then
	vi "$NOTES_LOCATION"
elif [ "$COMMAND" == "nano" ]; then
	nano "$NOTES_LOCATION"
else
	echo "Usage: $0 [show|edit|nano]"
fi
