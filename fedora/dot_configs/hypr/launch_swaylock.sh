#!/bin/sh
#
#      --timestr <format>
#          The time format for the indicator clock. Defaults to '%T'.
#
#      --datestr <format>
#          The date format for the indicator clock. Defaults to '%a, %x'.
#
#      -S, --screenshots
#          Display a screenshot.
#
#    --image $HOME/Photos/wallpaper/my-favorite/lake-sunrise.jpg \
#
#    --screenshots \
#
swaylock --ignore-empty-password \
    --fade-in 0.5 \
    --indicator \
    --clock \
    --timestr "%I:%M:%S %p" \
    --datestr "%a %d %b" \
    --font "SauceCodePro Nerd Font" \
    --font-size 80 \
    --indicator-thickness 20 \
    --indicator-radius 180 \
    --inside-color 23211b \
    --inside-clear-color FFE64D \
    --inside-ver-color FF9F1C \
    --inside-wrong-color F44747 \
    --ring-color 9DE2DD90 \
    --ring-clear-color FFE64D90 \
    --ring-wrong-color F4474790 \
    --line-color 23211b90 \
    --line-clear-color FFE64D90 \
    --line-wrong-color F4474790 \
    --separator-color 23211b90 \
    --key-hl-color 9DE2DD \
    --text-color 9DE2DD \
    --text-clear "Cancel" \
    --text-clear-color 23211b90 \
    --text-wrong "Failed" \
    --text-wrong-color 23211b90 \
    --screenshots \
    --effect-blur 20x1
