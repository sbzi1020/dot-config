if vim.g.enable_vim_debug then print "'my_keybindings' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
Handy key mapping function
-----------------------------------------------------------------------

@mode - string value below:
String value            Help page   Affected modes                              Vimscript equivalent
'' (an empty string)	mapmode-nvo Normal, Visual, Select, Operator-pending    :map
'n'                     mapmode-n   Normal                                      :nmap
'v'                     mapmode-v   Visual and Select                           :vmap
's'                     mapmode-s   Select                                      :smap
'x'                     mapmode-x   Visual                                      :xmap
'o'                     mapmode-o   Operator-pending                            :omap
'!'                     mapmode-ic  Insert and Command-line                     :map!
'i'                     mapmode-i   Insert                                      :imap
'l'                     mapmode-l   Insert, Command-line, Lang-Arg              :lmap
'c'                     mapmode-c   Command-line                                :cmap
't'                     mapmode-t   Terminal                                    :tmap

@key - the key to map
@mapping_command - the command to map
@opts - If provied, it will override the default `{noremap=true}`
--]]

local function set_key_mapping(mode, key, mapping_command, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, key, mapping_command, options)
end



-- Leader key: <Space>
set_key_mapping('n', '<Space>', '<NOP>', {silent=true})
vim.g.mapleader = ' '


--[[
-----------------------------------------------------------------------
Reload `init.lua`
-----------------------------------------------------------------------
--]]
set_key_mapping('n', '<leader>rr', ':luafile ~/.config/nvim/init.lua<CR>:setlocal nospell<CR>')



--[[
-----------------------------------------------------------------------
Normal settings
-----------------------------------------------------------------------
--]]

-- Y: Copy to the end of the line
set_key_mapping('n', 'Y', 'y$')

-- W: save, Q: quit, R: open Ranger/Vifm
set_key_mapping('n', 'W', ':w<CR>')
set_key_mapping('n', 'Q', ':q<CR>')
-- set_key_mapping('n', '<leader>r', ':RnvimrToggle<CR>')
-- set_key_mapping('n', '<silent>', '<leader>r :Vifm<CR>', {silent=true})
--
-- The `:luafile $MYVIMRC` doesn't work, as `:luafile` only reload the file itself. But all the
-- required modules (settins) are cached!!!
-- set_key_mapping('n', '<leader>r', ':luafile $MYVIMRC<CR>', {silent=true })


-- hh: <ESC> from `insert` mode
set_key_mapping('i', 'jj', '<ESC>')


-- cc: `cc` instead of `ci` (change inner)
set_key_mapping('n', 'cc', 'ci')


-- <Tab> and shift+<Tab> to cycle through the opened buffers
set_key_mapping('n', '<Tab>', ':bn<CR>')
set_key_mapping('n', '<S-Tab>', ':bp<CR>')


-- <leader><leader>: toggles between buffers
set_key_mapping('n', '<leader><leader>', '<c-^>', {silent=true})


-- <leader>th: save current file to HTML
set_key_mapping('n', '<leader>th', ':%TOhtml<CR>')


-- <leader>th: save current file to HTML
set_key_mapping('n', '<leader>e', ':Lexplore<CR>')



--[[
ctrl+s: replace all works under cursor. Do a `/pattern` which the `pattern`
is the word under cursor.

<c-r>(Ctrl+r), <c-w>(Ctrl+w) to Grab the word under cursor
--]]
-- nnoremap <silent> <c-s> *:%s//
-- nnoremap <silent> <c-s> :%s/\<<C-r><C-w>\>/
set_key_mapping('n', '<c-s>', ':%s/<C-r><C-w>//g<left><left>')


--[[
-----------------------------------------------------------------------
Split & window movement
-----------------------------------------------------------------------
--]]

-- Vertical split
set_key_mapping('n', '<leader>vs', ':vsplit<CR>')

-- Vertical split and run terminal inside
set_key_mapping('n', '<leader>ot', ':vsplit<CR>:terminal<CR>')

-- Vertical split and open vimrc, settings, keybindings, themes
set_key_mapping('n', '<leader>ov', ':vsplit<CR>:e $MYVIMRC<CR>')
--set_key_mapping('n', '<leader>os', ':vsplit<CR>:e ~/.config/nvim/lua/settings.lua<CR>')
--set_key_mapping('n', '<leader>op', ':vsplit<CR>:e ~/.config/nvim/lua/plugins.lua<CR>')
--set_key_mapping('n', '<leader>ok', ':vsplit<CR>:e ~/.config/nvim/lua/keybindings.lua<CR>')
--set_key_mapping('n', '<leader>ot', ':vsplit<CR>:e ~/.config/nvim/lua/themes.lua<CR>')

-- Move between windows
set_key_mapping('n', '<C-h>', ':wincmd h<CR>', {silent=true})
set_key_mapping('n', '<C-i>', ':wincmd l<CR>', {silent=true})
set_key_mapping('n', '<C-n>', ':wincmd j<CR>', {silent=true})
set_key_mapping('n', '<C-e>', ':wincmd k<CR>', {silent=true})

set_key_mapping('n', '<leader>m', ':wincmd h<CR>', {silent=true})
set_key_mapping('n', '<leader>i', ':wincmd l<CR>', {silent=true})
-- Can't use '<c-j>' and '<c-k>', as already used for ':cnext<CR>' and ':cNext<CR>'
-- set_key_mapping('n', '<C-j>', ':wincmd j<CR>', {silent=true})
-- set_key_mapping('n', '<C-k>', ':wincmd k<CR>', {silent=true})

-- Resize windows
set_key_mapping('n', '-', ':vertical resize -5<CR>', {silent=true})
set_key_mapping('n', '=', ':vertical resize +5<CR>', {silent=true})
set_key_mapping('n', '|', '<C-w>=', {silent=true})




--[[
-----------------------------------------------------------------------
Block and line movement
-----------------------------------------------------------------------

Visual Mode: Select and cursor enhancement

After make selection on lines:

shift+j: move selection down
shift+k: move selection up
<: move selection to left with one tab distance
>: move selection to right with one tab distance
--]]
set_key_mapping('v', 'N', ":m '>+1<CR>gv=gv")
set_key_mapping('v', 'E', ":m '<-2<CR>gv=gv")
set_key_mapping('v', '<', '<gv')
set_key_mapping('v', '>', '>gv')



--[[
-----------------------------------------------------------------------
Copy or cut to system clipboard
-----------------------------------------------------------------------

Ctrl+x: Cut
Ctrl+c: Copy
--]]
-- vmap <C-x> :!pbcopy<CR>
-- vmap <C-c> :w !pbcopy<CR><CR>

-- vmap <Leader>y "+y
-- vmap <Leader>d "+d
-- nmap <Leader>p "+p
-- nmap <Leader>P "+P
-- vmap <Leader>p "+p
-- vmap <Leader>P "+P



--[[
-----------------------------------------------------------------------
Visual mode snippets
-----------------------------------------------------------------------

<lead>;: Add ; at evey end of the line
<lead>": Add -- at evey end of the line
<lead>/: Add // at evey begin of the line
<lead><lead>/ - Remove // at evey begin of the line
--]]
set_key_mapping('v', '<leader>;', ':normal A;<ESC>')
set_key_mapping('v', '<leader>--', ':normal A"<ESC>')
set_key_mapping('v', '<leader>/', ':CommentToggle<CR>')



--[[
-----------------------------------------------------------------------
Plugin related
-----------------------------------------------------------------------
--]]

-- <leader><CR>: Toggle Goyo mode
set_key_mapping('n', '<leader><CR>', ':Goyo<CR>', {silent=true})


-- <leader>p: Fuzzy file searching
-- set_key_mapping('n', '<leader>p', ':FZF<CR>')
-- set_key_mapping('n', '<leader>p', ':lua require(\'telescope.builtin\').find_files()<CR>')
set_key_mapping('n', '<leader>p', ':lua require(\'telescope.builtin\').find_files({layout_strategy = \'vertical\', layout_config = {width=0.6}, previewer = false })<CR>', {silent=true})



-- <leader>f: Ripgrep full text searching
-- set_key_mapping('n', '<leader>f', ':Rg<space>')


-- <leader>B: List opened files (to select)
-- set_key_mapping('n', '<leader>b', ':Buffers<CR>', {silent=true})
set_key_mapping('n', '<leader>b', ':lua require(\'telescope.builtin\').buffers()<CR>', {silent=true})




--[[
-----------------------------------------------------------------------
Basic searching improvement
-----------------------------------------------------------------------
--]]

-- <leader>n: Close highlight
set_key_mapping('n', '<leader>n', ':nohl<CR>')

-- Search results center jump
set_key_mapping('n', 'h', 'nzz')
set_key_mapping('n', 'H', 'Nzz')


-- <leader>oq: Open quickfix list
-- <leader>cq: Close quickfix list
set_key_mapping('n', '<leader>oq', ':copen<CR>')
set_key_mapping('n', '<leader>cq', ':cclose<CR>')

-- <leader>ol: Open location list
-- <leader>cl: Close location list
set_key_mapping('n', '<leader>ol', ':lopen<CR>')
set_key_mapping('n', '<leader>cl', ':lclose<CR>')

-- Help search by in Telescope
set_key_mapping('n', '<leader>h', ':lua require(\'telescope.builtin\').help_tags()<CR>')


--[[
-----------------------------------------------------------------------
Advanced searching
-----------------------------------------------------------------------
--]]


--[[
<leader>f:

* Run the external `grep` command with the given searching keyword
* Auto jump to the first matching result
--]]
set_key_mapping('n', '<leader>f', ':silent grep ')


--[[
<leader>f:

* `silent` for hiding the `grep` standard output
* Run the external `grep` command with the given searching keyword
* Open the quick fix list
--]]
-- set_key_mapping('n', '<leader>f', ':silent grep!  | copen<C-Left><C-Left><C-Left>')


--[[
<leader>f:

* Use 'Telescope.builtin.grep_string()'
* Auto jump to the first matching result
* Open the quick fix list
--]]
-- set_key_mapping('n', '<leader>f', ':lua require(\'telescope.builtin\').grep_string()<CR>')

--[[
<leader>pb: Fuzzy files searching for in `~/my-shell/backup`
--]]
-- set_key_mapping('n', '<leader>pb', ':lua require(\'telescope.builtin\').find_files({ '..
--                                         'prompt_title = "< my-shell/backup files >",'..
--                                         'cmd = "~/my-shell/backup"'..
--                                     '})<CR>')


--[[
<leader>c: Fuzzy searching for vim comman hisotry
--]]
set_key_mapping('n', '<leader>ch', ':lua require(\'telescope.builtin\').command_history()<CR>')


-- `ctrl+j` and `ctrl+k`: Cycle through the quick fix list and center the current result line
set_key_mapping('n', '<c-j>', ':cnext<CR>zz')
set_key_mapping('n', '<c-k>', ':cNext<CR>zz')



--[[
-----------------------------------------------------------------------
Coding and LSP related
-----------------------------------------------------------------------

gd:         Go to definition
gD:         Go to declaration
gf:         Go to file
gi:         Implementation
gr:         List references in current buffer
rn:         Rename symbols
K:          Show documentation
<leader>ff: Format code

srn:        Smart rename, it will show all matched files in a single window,
            then I can run `%s/XXXX/YYYY/g` to do a replacement on all matched
            files!!!
--]]
-- vim.cmd 'nmap <silent> gd <Plug>(coc-definition)'
-- vim.cmd 'nmap <silent> gy <Plug>(coc-type-definition)'
-- vim.cmd 'nmap <silent> gi <Plug>(coc-implementation)'
-- vim.cmd 'nmap <silent> gr <Plug>(coc-references)'
-- vim.cmd 'nmap <leader>rn <Plug>(coc-rename)'
-- vim.cmd 'nnoremap <leader>ff :call CocAction(\'format\')<CR>'
-- vim.cmd 'nnoremap <silent> <leader>t :<C-u>CocList -I symbols<CR>'
-- vim.cmd 'nnoremap <silent> K :call CocAction(\'doHover\')<CR>'
-- vim.cmd 'nnoremap <silent> srn :CocSearch <C-R>=expand("<cword>")<CR><CR>'
-- 
-- -- <leader>se: Show diagnostic message into location list
-- -- ctrl-n:     Go to next diagnostic position
-- -- ctrl-p:     Go to prev diagnostic position
-- vim.cmd 'nnoremap <leader>se :CocList diagnostics<CR>'
-- vim.cmd 'nmap <silent> <c-p> <Plug>(coc-diagnostic-prev)'
-- vim.cmd 'nmap <silent> <c-n> <Plug>(coc-diagnostic-next)'



--[[
Rust related

<leader>cc: run shell command `cargo check`
<leader>cb: run shell command `cargo build --release`
<leader>cr: run shell command `cargo run`
--]]
-- set_key_mapping('n', '<leader>cc', ':!cargo check<CR>')
-- set_key_mapping('n', '<leader>cb', ':!cargo build --release<CR>')
-- set_key_mapping('n', '<leader>cr', ':!cargo run <CR>')
-- set_key_mapping('n', '<leader>cw', ':!cargo watch -c -x run<CR>')
-- set_key_mapping('n', '<leader>cc', '::vsplit<CR>:terminal cargo check<CR>')
-- set_key_mapping('n', '<leader>cb', '::vsplit<CR>:terminal cargo build --release<CR>')
-- set_key_mapping('n', '<leader>cr', '::vsplit<CR>:terminal cargo run <CR>')
-- set_key_mapping('n', '<leader>ct', '::vsplit<CR>:terminal cargo test<CR>')





--[[
-----------------------------------------------------------------------
<leader>sc: Toggle spell checking
-----------------------------------------------------------------------
--]]
function is_enabled_spell()
    -- vim.wo.spell = !vim.wo.spell
    if vim.wo.spell == true then vim.wo.spell = false
    else vim.wo.spell = true
    end
end

set_key_mapping('n', '<leader>sc', '<cmd>lua is_enabled_spell()<CR>')



--[[
-----------------------------------------------------------------------
Handy setting for coding in insert mode based on different 'FileType'
-----------------------------------------------------------------------

.js, .ts, .rs, .toml, .fish

--]]
vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> ;; <ESC>A;'
-- -- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> ,, <ESC>A,'
-- -- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> .. <ESC>A.'
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,toml,fish inoremap,go <buffer> -- ""<left>'
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go inoremap <buffer> ` ``<left>'
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> (<CR> <ESC>i<space>(<CR>)<ESC>O'
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> [<CR> <ESC>i<space>[<CR>]<ESC>O'
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,cpp inoremap <buffer> {<CR> <ESC>i<space>{<CR>}<ESC>O'
-- vim.cmd 'autocmd FileType toml inoremap <buffer> { {  }<left><left>'
-- vim.cmd 'autocmd FileType toml inoremap <buffer> [ [  ]<left><left>'


--[[
.md

nn - Go to the next '<++>' placeholder
hh - Add Highlight content
bb - Add Bold content
aa - Add Link content
--]]
vim.cmd 'autocmd FileType markdown inoremap <buffer> nnn <ESC>/<++><CR>:nohl<CR>c4l'
vim.cmd 'autocmd FileType markdown inoremap <buffer> bb **** <++><ESC>F*2;a'
vim.cmd 'autocmd FileType markdown inoremap <buffer> aa [](<++>) <++><ESC>F[a'
vim.cmd 'autocmd FileType markdown inoremap <buffer> img ![](<++>) <++><ESC>F[a'
vim.cmd 'autocmd FileType markdown inoremap <buffer> /br <CR></br><CR><CR>'
vim.cmd 'autocmd FileType markdown inoremap <buffer> ``` ```<CR><ESC>i```<ESC>kA'
vim.cmd 'autocmd FileType markdown inoremap <buffer> { {  }<left><left>'



--[[
-----------------------------------------------------------------------
Handy file navigation
-----------------------------------------------------------------------
--]]

-- `mm`: Make a gloabl mark

-- `gb`: Go back to the global mark
set_key_mapping('n', 'gb', '`Mzz')


--[[
-----------------------------------------------------------------------
Disable arrow keys
-----------------------------------------------------------------------
--]]
set_key_mapping('n', '<Left>', '<nop>')
set_key_mapping('n', '<Right>', '<nop>')
set_key_mapping('n', '<Up>', '<nop>')
set_key_mapping('n', '<Down>', '<nop>')
set_key_mapping('i', '<Left>', '<nop>')
set_key_mapping('i', '<Right>', '<nop>')
set_key_mapping('i', '<Up>', '<nop>')
set_key_mapping('i', '<Down>', '<nop>')
set_key_mapping('v', '<Left>', '<nop>')
set_key_mapping('v', '<Right>', '<nop>')
set_key_mapping('v', '<Up>', '<nop>')
set_key_mapping('v', '<Down>', '<nop>')


--[[
-----------------------------------------------------------------------
Colemak cursor navigation mapping
h/n/e/i
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'e', 'k')
set_key_mapping('n', 'm', 'h')
set_key_mapping('n', 'i', 'l')
set_key_mapping('n', 'n', 'j')
set_key_mapping('v', 'm', 'h')
set_key_mapping('v', 'e', 'k')
set_key_mapping('v', 'i', 'l')
set_key_mapping('v', 'n', 'j')


--[[
-----------------------------------------------------------------------
Colemak cursor navigation mapping

" Current line movement
"
" Beginning of line < N  I > End of line
"
" H --> 0 (Go to the beginning of current line)
" I --> $ (Go to the end of current line)
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'M', '0')
set_key_mapping('n', 'I', '$')


--[[
-----------------------------------------------------------------------
Colemak cursor navigation mapping

" Screen movement
"
"     ^  Top of screen
"     U
"     E
"     v Bottom of screen
"
" U --> H (Go to the top of screen)
" E --> L (Go to the bottom of screen)
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'J', '{')
set_key_mapping('n', 'K', '}')


--[[
-----------------------------------------------------------------------
Colemak edit mapping
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'l', 'i')
set_key_mapping('n', 'L', 'I')



--[[
-----------------------------------------------------------------------
Colemak edit mapping
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'N', '<nop>')


--[[
-----------------------------------------------------------------------
'oo' -> 'ciw'
-----------------------------------------------------------------------
--]]
set_key_mapping('n', 'M', '%')

