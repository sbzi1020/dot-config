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
set --local percent $argv[2]

printf ">>> param_count: %d, action: %s, percent: %s\n" $param_count $action $percent
if [ $param_count -lt 2 ]
    printf ">> Usage: set-brightness increase|decrease percentage\n"
    exit 0
end

if [ $action != "increase"  -a  $action != "decrease" ]
    printf ">> Usage: set-brightness increase|decrease percentage\n"
    exit 0
end

# -------------------------------------------------------------------------
# man brightnessctl
# -------------------------------------------------------------------------
if [ $action = "increase" ]
    set --local value "$percent%+"
    brightnessctl set $value
else if [ $action = "decrease" ]
    set --local value "$percent%-"
    brightnessctl set $value
end
