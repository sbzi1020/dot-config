#!/bin/sh
bluetoothctl -- power on
bluetoothctl -- connect 14:85:09:F0:EB:78

echo "Open 'pavucontrol' and go to 'Congfiguration' tab, set 'Profile: Off' and select 'Fion Airpod 2'."
