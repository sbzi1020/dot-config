#!/usr/local/bin/fish
set --local internal_speaker_sink_no (pamixer --list-sinks | rg "Internal" | awk '{print $1}')
echo "HDMI snik no: $internal_speaker_sink_no"
sysctl hw.snd.default_unit=$internal_speaker_sink_no
