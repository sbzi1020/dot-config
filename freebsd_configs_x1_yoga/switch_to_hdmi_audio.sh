#!/usr/local/bin/fish
set --local hdmi_sink_no (pamixer --list-sinks | rg "HDMI" | awk '{print $1}')
echo "HDMI snik no: $hdmi_sink_no"
sysctl hw.snd.default_unit=$hdmi_sink_no
