#!/usr/bin/fish
set --local DEVICE_ID (wpctl status | rg "HDMI" | head -n 1 | awk '{print $3}' | sed -e "s/\.//g")
# echo "DEVICE_ID: $DEVICE_ID"
wpctl set-mute $DEVICE_ID toggle
