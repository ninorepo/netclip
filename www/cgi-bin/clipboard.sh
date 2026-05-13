#!/bin/bash
# File: /usr/lib/cgi-bin/clipboard.sh
# chmod +x /usr/lib/cgi-bin/clipboard.sh

export DISPLAY=:0
export XAUTHORITY=~/.Xauthority

echo "Content-Type: text/plain"
echo ""

# Ambil isi clipboard X11
DISPLAY=:0 xclip -selection clipboard -o 2>/dev/null

