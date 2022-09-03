if vim.g.enable_vim_debug then print "'my_settings' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
Set options
-----------------------------------------------------------------------

The Neovim Lua API provide 3 tables to set options:

`vim.o`  for setting global options
`vim.bo` for setting buffer-scoped options
`vim.wo` for setting window-scoped options

Unfortunately setting an option is not as straightforward in Lua as in
Vimscript. In Lua you need to update the global table then either the
buffer-scoped or the window-scoped table to ensure that an option is
correctly set. Otherwise some option like expandtab will only be valid
for the starting buffer of a new Neovim instance.

To know which one to set, check Vim help pages. For instance for
`expandtab`

Fortunately the Neovim team is working on an universal and simpler option
interface, see PR#13479. In the meantime you can use this function as a
workaround
--]]

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function set_options(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end


-- Indent space
local indent = 4


-- Enable hybrid number (Absolute and relative number)
set_options('w', 'number', true)
set_options('w', 'relativenumber', true)


-- Hide the vim mode, as already done that in `galaxyline`
vim.cmd 'set noshowmode'


-- Disable SWAP file
vim.cmd 'set noswapfile'


-- Share system clipboard
set_options('o', 'clipboard', 'unnamedplus')


-- Allow us to do case-insensitive file searching
set_options('o', 'ignorecase', true)
set_options('o', 'smartcase', true)


-- Show or disable a vertical bar to indicate the column limit position.
set_options('o', 'colorcolumn', '80')


-- Tab related
set_options('b', 'expandtab', true)
set_options('b', 'shiftwidth', indent)
set_options('b', 'smartindent', true)
set_options('b', 'tabstop', indent)
set_options('b', 'softtabstop', indent)
set_options('o', 'shiftround', true)


-- Show some invisible characters (tabs...)
set_options('w', 'list', true)


-- Send more characters for redraws, should make scrolling faster
set_options('o', 'ttyfast', true)
set_options('o', 'lazyredraw', true)


-- Enable mouse use in all modes
set_options('o', 'mouse', 'a')


--[[
Enable spell checking

`]s` - go to next misspelled word
`[s` - go to prev misspelled word
`z=` - show the correct candidate list
--]]
vim.cmd 'set spell spelllang=en_us'


-- Open vertical split on the right side (your cursor will there)
set_options('o', 'splitright', true)


-- Completion options (for deoplete)
set_options('o', 'completeopt', 'menuone,noinsert,noselect')


-- Enable modified buffers in background
set_options('o', 'hidden', true)


-- True color support
set_options('o', 'termguicolors', true)


-- Scroll off
set_options('o', 'scrolloff', 10)


-- Default file explore window size
vim.g.netrw_winsize = 20


-- Enable persistent undo
vim.cmd 'set undofile'
vim.cmd 'set undodir=~/.config/nvim/undo'


-- Enable cursor line
set_options('w', 'cursorline', true)

-- `CursorLine` highlight group affect cursor position's line number and text
set_options('w', 'cursorlineopt', 'both')


--[[
--------------------------------------------------------------------------
File type auto detection and file search settings
--------------------------------------------------------------------------

Enable loading the pluging file for the particular file type. This
actually loads the file "ftplugin.vim" in 'runtimepath'.  The result
is that when a file is edited its plugin file is loaded (if there is one
for the detected filetype).

This setting will turn on the `filetype on` as well.
--]]
vim.cmd 'filetype plugin on'

-- Search down in all sub-dirs and provide `tab-completion` for all files.
vim.cmd 'set path+=**'



--[[
--------------------------------------------------------------------------
Advanced searching
--------------------------------------------------------------------------

Use external `ripgrep` to search content in files and fill the result
into to the quick fix list.

You need to install `ripgrep` first, plz have look at here:
https://github.com/BurntSushi/ripgrep#installation

By default, `ripgrep` will respect your .gitignore and automatically skip
hidden files/directories and binary files. So the search will be very fast!!!
--]]
vim.cmd 'set grepprg=rg\\ --no-heading\\ --vimgrep'
vim.cmd 'set grepformat=%f:%l:%c:%m'



--[[
-----------------------------------------------------------------------
Correct the wrong detected filetype
-----------------------------------------------------------------------
--]]
--vim.cmd 'autocmd BufEnter *.fish set filetype=fish'



--[[
-----------------------------------------------------------------------
Disable spell checking for all source code file by default.
But you can toggle the spell checking by press `<leader>sc` at any given
time.
-----------------------------------------------------------------------

.js, .ts, .rs, .toml, .fish, lua

--]]
vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,lua,tmux,yaml,vim,fish,toml,json,cmake,markdown,css,conf,sh,man setlocal nospell'

--[[
-----------------------------------------------------------------------
Disable spell checking for opening terminal
-----------------------------------------------------------------------
--]]
vim.cmd 'autocmd TermOpen * setlocal nospell'



--[[
-----------------------------------------------------------------------
Enable highlight when yanked
-----------------------------------------------------------------------
--]]
vim.cmd [[
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
    augroup END
]]


