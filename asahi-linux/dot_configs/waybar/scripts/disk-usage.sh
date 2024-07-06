#!/usr/bin/fish

set --local disk_info (df -Th | rg btrfs | awk '{print $3,$4,$5}')
set --local total (echo "$disk_info" | cut -d ' ' -f1)
set --local used (echo "$disk_info" | cut -d ' ' -f2)
set --local left (echo "$disk_info" | cut -d ' ' -f3)

echo "$used / $total"
