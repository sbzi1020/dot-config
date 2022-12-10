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


-- hh: <ESC> from `insert` mode
set_key_mapping('i', 'hh', '<ESC>')


-- cc: `cc` instead of `ci` (change inner)
set_key_mapping('n', 'cc', 'ciw')


-- <Tab> and shift+<Tab> to cycle through the opened buffers
set_key_mapping('n', '<Tab>', ':bn<CR>')
set_key_mapping('n', '<S-Tab>', ':bp<CR>')


-- <leader><leader>: toggles between buffers
set_key_mapping('n', '<leader><leader>', '<c-^>', {silent=true})


-- <leader>th: save current file to HTML
set_key_mapping('n', '<leader>th', ':%TOhtml<CR>')


set_key_mapping('n', '<leader>e', ':Lexplore<CR>')



--[[
ctrl+s: replace all words under cursor. Do a `/pattern` which the `pattern`
is the word under cursor.
<c-r>(Ctrl+r), <c-w>(Ctrl+w) to Grab the word under cursor
--]]
set_key_mapping('n', '<c-s>', ':%s/<C-r><C-w>//g<left><left>')


--[[
-----------------------------------------------------------------------
Split & window movement
-----------------------------------------------------------------------
--]]

-- Vertical split
set_key_mapping('n', '<leader>vs', ':vsplit<CR>')

-- Vertical split and open vimrc, settings, keybindings, themes
set_key_mapping('n', '<leader>ov', ':vsplit<CR>:e $MYVIMRC<CR>')

-- Move between windows
set_key_mapping('n', '<leader>m', ':wincmd h<CR>', {silent=true})
set_key_mapping('n', '<leader>i', ':wincmd l<CR>', {silent=true})

-- Resize windows
set_key_mapping('n', '-', ':vertical resize -5<CR>', {silent=true})
set_key_mapping('n', '=', ':vertical resize +5<CR>', {silent=true})
set_key_mapping('n', '|', '<C-w>=', {silent=true})




--[[
-----------------------------------------------------------------------
Block and line movement
-----------------------------------------------------------------------
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
--]]
set_key_mapping('v', '<leader>;', ':normal A;<ESC>')
set_key_mapping('v', '<leader>--', ':normal A"<ESC>')
set_key_mapping('v', '<leader>,', ':normal A,<ESC>')
set_key_mapping('v', '<leader>/', ':CommentToggle<CR>')

--[[
-----------------------------------------------------------------------
Plugin related
-----------------------------------------------------------------------
--]]

-- <leader><CR>: Toggle Goyo mode(fullscreen focus mode)
set_key_mapping('n', '<leader><CR>', ':Goyo<CR>', {silent=true})


-- <leader>p: Fuzzy file searching
set_key_mapping('n', '<leader>p', ':lua require(\'telescope.builtin\').find_files({layout_strategy = \'vertical\', layout_config = {width=0.6}, previewer = false })<CR>', {silent=true})

-- <leader>B: List opened files (to select)
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

-- Help search by in Telescope
set_key_mapping('n', '<leader>h', ':lua require(\'telescope.builtin\').help_tags()<CR>')

--[[
-----------------------------------------------------------------------
Advanced searching
-----------------------------------------------------------------------
--]]

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


set_key_mapping('n', 'M', '0')
set_key_mapping('n', 'I', '$')



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


