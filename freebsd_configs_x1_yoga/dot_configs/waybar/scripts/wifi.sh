#!/usr/local/bin/fish

set --local wlan_nic  "wlan0"

set --local wifi_icon " "
set --local ip_address (ifconfig wlan0 | rg -e "inet" | awk '{print $2}')

echo "$wifi_icon $ip_address"
