## Backup your configs
- copy the files to your `backup configs`
    - `fish`: `cp -rvf ~/.config/fish .`
    - `lf`: `cp -rvf ~/.config/lf .`
    - `nvim`: `cp -rvf ~/.config/nvim .`
    - `.tmux_line`: `cp -rvf ~/.tmux_line ./dot_tmux_line`
    - `.tmux.conf`: `cp -rvf ~/.tmux.conf ./dot_tmux.conf`
    - `.alacritty.yml`: `cp -rvf ~/.alacritty.yml ./dot_alacritty.yml`
- `git push master` to upload to the git

## setup
1. fish
- show the `fish` directory: `which fish` 
- download: `brew install fish alacritty`
- change bash to fish: `chsh -s {fish_directory}`
2. git 
- set `git config username&&email`
- follow the github doc to generate `ssh` key and paste the `ssh` key to the setting
- check `git`: `git config --global --list`
- pull the `dot-config` 

- copy the `dot-config` to the local
    - `fish`: `cp -rvf ./fish ~/.config/ `
    - `lf`: `cp -rvf ./lf ~/.config/ `
    - `nvim`: `cp -rvf ./nvim ~/.config/`
    - `.tmux_line`: `cp -rvf ./dot_tmux_line ~/.tmux_line `
    - `.tmux.conf`: `cp -rvf ./dot_tmux.conf ~/.tmux.conf `
    - `.alacritty.yml`: `cp -rvf ./dot_alacritty.yml ~/.alacritty.yml `
    - install font
- install lf and fzf: `$ doas pacman -S lf fzf`
- `$ source ~/.config/fish/config.fish` to reload 
- `$ vc` to reload the vim config and `:packerupdate`

#### error
Delete the plugin ----> If you enter the vim and it shows an error, you may go to the `vc` to find the `my_plugin`, and copy the delete command to delete it.
and reopen vim to refresh and reinstall the plugin. (maybe it is old version which caches in local and newly one which just copy have conflict.)
