#!/usr/local/bin/fish

set --local usage = (zfs list | grep "/zroot" | awk '{print $2,$3}')
set --local used (echo "$usage" | cut -d ' ' -f2)
set --local total (echo "$usage" | cut -d ' ' -f3)
# echo "$usage"
echo "$used / $total"
