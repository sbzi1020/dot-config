#!/usr/bin/fish

set wallpaper_folder $argv[1]

#
# `if` help:  https://fishshell.com/docs/current/language.html#the-if-statement
# `test` help: https://fishshell.com/docs/current/cmds/test.html
#
if test -z $wallpaper_folder
   echo "Usage: change_wallpaper.sh [wallpaper_folder]"
   exit 0
end

set random_file (ls $wallpaper_folder |sort -R |tail -n1)
set fullpath_wallpaper "$wallpaper_folder$random_file"
echo "wallpaper_folder: $wallpaper_folder"
echo "random_file: $random_file"
echo "fullpath_wallpaper: $fullpath_wallpaper"

swww img --transition-type none $fullpath_wallpaper && wal -i $fullpath_wallpaper
pkill waybar
# sleep 1
dbus-run-session waybar > ~/.waybar.log
