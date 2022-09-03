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
    - `fish`: `cp -rvf ./fish ~/.config/fish `
    - `lf`: `cp -rvf ./lf ~/.config/lf `
    - `nvim`: `cp -rvf ./nvim ~/.config/nvim `
    - `.tmux_line`: `cp -rvf ./dot_tmux_line ~/.tmux_line `
    - `.tmux.conf`: `cp -rvf ./dot_tmux.conf ~/.tmux.conf `
    - `.alacritty.yml`: `cp -rvf ./dot_alacritty.yml ~/.alacritty.yml `
    - install font

