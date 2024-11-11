#!/bin/sh

#
# Remove preious session stuff
#
rm -rf /var/run/user/`id -u`/*
rm -rf ~/.hyprland.err ~/.hyprland.log
#
#
# Launch Hyprland with logging
#
Hyprland --config ~/.config/hypr/hyprland.conf 2>~/.hyprland.err >~/.hyprland.log
