#!/usr/bin/fish

set wlan_nic  "wlp2s0"
# set --local wlan_nic  "wlan0"

ip add show dev $wlan_nic | grep -e "UP" -e "inet" > ~/.network_result
set --local lines (wc -l ~/.network_result | awk '{print $1}')
set --local wifi_icon " "
set --local p_address ""

if test "$lines" -gt 1
    set ip_address (sed -n '2p' ~/.network_result | awk '{print $2}')
else
    set wifi_icon "睊"
end

echo "$wifi_icon $ip_address"
