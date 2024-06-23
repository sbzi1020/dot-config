#!/usr/bin/fish

# -------------------------------------------------------------------------
# Bash -> Fish syntax quick tutorial:
#
# https://fishshell.com/docs/current/fish_for_bash_users.html
# -------------------------------------------------------------------------

# -------------------------------------------------------------------------
# Check parameter, run `man test` to learn how to compare strings and numbers
#
# `-a`: logic add
# `-o`: logic or
# -------------------------------------------------------------------------
set --local param_count (count $argv)
set --local action $argv[1]
printf ">>> param_count: %d, action: %s\n" $param_count $action
if [ $param_count -lt 1 ]
    printf ">> Usage: set-brightness increase|decrease\n"
    exit 0
end

if [ $action != "increase"  -a  $action != "decrease" ]
    printf ">> Usage: set-brightness increase|decrease\n"
    exit 0
end

# -------------------------------------------------------------------------
# https://wiki.archlinux.org/title/backlight
#
# Hardware interfaces > ACPI
# -------------------------------------------------------------------------
set --local intel_brightness /sys/class/backlight/intel_backlight/brightness
set --local max_brightness /sys/class/backlight/intel_backlight/max_brightness

set --local max_value (cat $max_brightness)
set --local five_percent_value (math $max_value / 20)
set --local current_value (cat $intel_brightness)
printf ">>> current_brightness: %d, max_brightness: %d, five_percent_value: %d\n" $current_value $max_value $five_percent_value

set --local new_value $current_value
if [ $action = "increase" ]
    set new_value (math $current_value + $five_percent_value)
    if [ $new_value -gt $max_value ]
        set new_value $max_value
    end
else if [ $action = "decrease" ]
    set new_value (math $current_value - $five_percent_value)
    if [ $new_value -lt 0 ]
        set new_value 0
    end
end

printf ">>> new_brightness: %d" $new_value
echo $new_value > $intel_brightness
