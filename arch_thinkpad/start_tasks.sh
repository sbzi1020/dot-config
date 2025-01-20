#!/bin/fish

# Browser
hyprctl dispatch workspace 2
sleep 1
hyprctl dispatch exec GDK_DPI_SCALE=1.8 dbus-run-session brave > ~/temp/launch_brave_browser.log
sleep 1

# Obsidian
hyprctl dispatch workspace 3
sleep 2
hyprctl dispatch exec GDK_SCALE=1.8 obsidian

# eudic
sleep 3
hyprctl dispatch workspace 5
sleep 1
hyprctl dispatch exec QT_SCALE_FACTOR=1.8 eudic

sleep 1
hyprctl dispatch workspace 1

