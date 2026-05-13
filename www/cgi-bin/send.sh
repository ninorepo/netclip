#!/bin/sh

export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

LOGFILE="/tmp/messages.log"

# wajib HTTP header
echo "Content-Type: text/plain"
echo

# read POST body
BODY=$(cat)

# simpan log
echo "$BODY" >> "$LOGFILE"

# update clipboard (kalau ada X server)
echo "$BODY" | xclip -selection clipboard 2>/dev/null

echo "OK"
