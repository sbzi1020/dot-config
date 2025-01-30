rm -rf /var/run/user/`id -u`/*
rm -rf ~/.hyprland.err ~/.hyprland.log

Hyprland --config ~/.config/hypr/hyprland.conf 2>~/.hyprland.err >~/.hyprland.log
