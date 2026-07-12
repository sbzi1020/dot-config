set --export EDITOR "emacs --no-window-system"

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
