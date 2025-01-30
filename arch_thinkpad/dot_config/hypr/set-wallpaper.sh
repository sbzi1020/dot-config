#!/bin/sh

#
# `swww init` will fail in high resolution case (like 5K in VM), so this delay helps a lot
#
sleep 1

#
# Disable transition animation
#
# swww init 2>~/.swww-daemon.err > ~/.swww-daemon.log && swww img --transition-type none ~/Photos/wallpaper/my-favorite/lake-sunrise.jpg 2>~/.swww.err > ~/.swww.log

#
# Enable transition animation
#
rm -rf ~/.swww.err ~/.swww.log ~/.swww-daemon.err ~/.swww-daemon.log
swww init 2>~/.swww-daemon.err > ~/.swww-daemon.log && swww img --transition-type wipe --transition-angle 45 ~/Photos/wallpaper/my-favorite/lake-sunrise.jpg 2>~/.swww.err > ~/.swww.log

