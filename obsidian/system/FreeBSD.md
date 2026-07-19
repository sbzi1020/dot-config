[[ZFS]]
[[bhyve vm]]

## Initial setup
### [[Common operations]]
### doas
```bash
su pkg install doas
which doas

vi /usr/local/etc/doas.conf
# add one rule inside it
# `permit nopass keepenv lab as root`

# change the pevilige of user
pw groupmod wheel -m lab

# set safe permission: make sure only root can access
chown root:wheel /usr/local/etc/doas.conf
chmod 600 /usr/local/etc/doas.conf

# try to use it
doas pkg install XXXXX
```

### Fish
```bash
# check your current shell
echo $SHELL # /bin/sh
doas pkg install fish
which fish # /usr/local/bin/fish
chsh -s /usr/local/bin/fish

# relogin again 
echo $SHELL # /usr/local/bin/fish
```
It should be automatically added to `/etc/shells`, if not, then do:
```bash
echo /usr/local/bin/fish >> /etc/shells
# rerun `chsh` again
chsh -s /usr/local/bin/fish
```
add a `fish` folder and a new file `.config/fish/config.fish`
```
set --export EDITOR "nvim"
#--------------------------------------------------------
# 1. Enable `vi mode` key bindings
# 2. bind `jj` to escape
# 3. bind `ctrl+l` to accept the first suggection
#
# Tips: When u don't know what key (or key combo) to write
#       into the `bind` command, just run `fish_key_reader`
#       binary and press the key (or key combo), it will 
#       print out which `key` you should put into the `bind`
#       command.
#--------------------------------------------------------
set -g fish_key_bindings fish_vi_key_bindings
bind -M insert -m default jj  backward-char force-repaint
bind -M insert \f accept-autosuggestion

#--------------------------------------------------------
# Abbreviation
#--------------------------------------------------------
source $HOME/.config/fish/abbr.fish
# abbr ll "ls -lht"
# abbr vim "nvim"
```

### git
```bash
doas pkg install git
git --version
git config --global user.name "Fion Li"
git config --global user.email "li.shangzi3@gmail.com"
```
then setup the ssh:
```bash
# generate ssh key
ssh-keygen -t ed25519 -C "li.shangzi3@gmail.com"
# All `Enter` default setting

# start ssh agent and add your key
eval "$(ssh-agent -s)" # bash
eval (ssh-agent -c) # fish
# Agent pid 2813
ssh-add ~/.ssh/id_ed25519
# Identity added: /home/lab/.ssh/id_ed25519 (li.shangzi3@gmail.com)
cat ~/.ssh/id_ed25519.pub
# copy your publich key and paste to github: settings>ssh keys
```
### Neovim
```bash
doas pkg install neovim
which nvim
```
Add a `nvim` folder and a new file `.config/nvim/init.lua`
	If you have already installed Git, then `nvim` , it will automatically installed all packages in your `init.lua`
### Kitty (terminal)
```bash
doas pkg install kitty
kitty --version
```
Add a `kitty` and a new file `.config/kitty/kitty.conf`
```
confirm_os_window_close 0
# Fonts
font_family         JetBrainsMonoNerdFont
bold_font           auto
italic_font         auto
bold_italic_font    auto
font_size           16

# Misc
scrollback_lines    5000
scrollbar           never

# UI
background_opacity  0.9

# Layouts
enabled_layouts     Tall,stack

window_padding_width    10
window_border_width     1

# Tab
tab_bar_edge            bottom
tab_bar_align           center
tab_bar_min_tabs        1
tab_title_max_length    40
tab_bar_margin_height   40
tab_bar_style           slant

# Keybinding
kitty_mode              ctrl+shift

# change font size
map ctrl+minus change_font_size all -2.0
map ctrl+equal change_font_size all +2.0

# Scrolling way
map alt+n scroll_line_up
map alt+m scroll_line_down

# split windows
map alt+t new_window
map alt+w close_window
map alt+i set_window_title
map alt+h neighboring_window left
map alt+l neighboring_window right
map alt+j neighboring_window bottom
map alt+k neighboring_window top

# toggle the stack layout
map alt+z toggle_layout stack

# resize window
map alt+r start_resizing_window

map ctrl+shift+space launch --stdin-source=@screen_scrollback --type=overlay nvim +"set nospell" -
```
Add font:
```bash
pkg search nerd-fonts
pkg install nerd-fonts
```