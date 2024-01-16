if vim.g.enable_vim_debug then print "'my_tmuxline' has been reloaded >>>" end

--[[
-----------------------------------------------------------------------
'edkolev/tmuxline.vim'
-----------------------------------------------------------------------

tmuxline separate in 3 areas: Left, Middle, Right. Then you can specific
what information you want to display in which areas:

Left      - `a, b, c`
Middle    - `cwin` and `win` affect the current (active) window and the in-active windows respectively.
Rght      - `x, y, z`

#H    Hostname of local host
#h    Hostname of local host without the domain name
#F    Current window flag
#I    Current window index
#S    Session name
#W    Current window name
#R    Time
#a    Day of week
#Y    Year
#(shell-command)  First line of the command's output
--]]
vim.cmd('let g:tmuxline_preset = { "a": "#S", "b": "#(whoami)", "c": "", "cwin": "#I #W", "win": "#I #W", "x": "%R", "y": "", "z": ""}')
