#!/usr/local/bin/fish

set --local ethernet_nic  "igc0"

set --local ethernet_icon ""
set --local ip_address (ifconfig igc0 | rg -e "inet" | awk '{print $2}')

echo "$ethernet_icon $ip_address"
