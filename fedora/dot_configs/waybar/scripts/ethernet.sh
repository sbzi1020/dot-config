#!/usr/bin/fish

# set wlan_nic  "wlp3s0"
set --local ethernet_nic  "enp1s0"

ip add show dev $ethernet_nic | grep -e "UP" -e "inet" > ~/.ethernet_result
set --local lines (wc -l ~/.ethernet_result | awk '{print $1}')
set --local ethernet_icon ""
set --local ip_address ""

if test "$lines" -gt 1
    set ip_address (sed -n '2p' ~/.ethernet_result | awk '{print $2}')
else
    set wifi_icon ""
end

echo "$ethernet_icon $ip_address"
