if vim.g.enable_vim_debug then print "'my_keybindings' has been loaded >>>" end

local keymap = vim.keymap

--[[
-------------------------------------------------------------------------------
vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
-------------------------------------------------------------------------------

@mode - string, avaialbe value:
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

    - string[], for multiple modes, e.g. '{'n', 'v'}

@lhs - LeftHandSide, the keys you want to map
@rhs - RightHandeSide, map to command string or lua function
@opts - {
        • {buffer}? (`integer|boolean`) Creates buffer-local mapping,
            `0` or `true` for current buffer.
        • {remap}? (`boolean`, default: `false`) Make the mapping
            recursive. Inverse of {noremap}.
        • "noremap" disables |recursive_mapping|, like |:noremap|
        • "desc" human-readable description.
        • "callback" Lua function called in place of {rhs}.
        • "replace_keycodes" (boolean) When "expr" is true, replace
            keycodes in the resulting string (see
            |nvim_replace_termcodes()|). Returning nil from the Lua
            "callback" is equivalent to returning an empty string.
    }
--]]


-- Leader key: <Space>
keymap.set('n', '<Space>', '<NOP>', {silent=true})
vim.g.mapleader = ' '
vim.g.maplocalleader = "\\"


-------------------------------------------------------------------------------
-- Reload `init.lua`
-------------------------------------------------------------------------------
keymap.set('n',
    '<leader>rr',
    ':luafile ~/.config/nvim/init.lua<CR>:setlocal nospell<CR>',
    { desc = "Reload neovim config" })




-------------------------------------------------------------------------------
-- Normal settings
-------------------------------------------------------------------------------

-- Y: Copy to the end of the line
keymap.set('n', 'Y', 'y$', { desc = "Copy to end of line" })

-- H and L instead of '^' and '$'
keymap.set('n', 'H', '^', { desc = "Move to begining of line" })
keymap.set('n', 'L', '$', { desc = "Move to end of line" })

-- W: save, Q: quit
keymap.set('n', 'W', ':w<CR>', { desc = "Save current buffer" })
keymap.set('n', 'Q', ':q<CR>', { desc = "Quit current buffer" })

-- jj: <ESC> from `insert` mode
keymap.set('i', 'jj', '<ESC>')

-- cc: `cc` instead of `ci` (change inner)
-- keymap.set('n', 'cc', 'ci')

-- <Tab> and shift+<Tab> to cycle through the opened buffers
keymap.set('n', '<Tab>', ':bn<CR>', { desc = "Switch next buffer" })
keymap.set('n', '<S-Tab>', ':bp<CR>', { desc = "Switch prev buffer" })

-- <leader><leader>: toggles between buffers
keymap.set('n', '<leader><leader>', '<c-^>', {
    silent=true,
    desc = "Swith between last and current buffer" })

-- <leader>th: save current file to HTML
keymap.set('n', '<leader>th', ':%TOhtml<CR>', { desc = "Save as HTML" })

-- <leader>th: save current file to HTML
-- keymap.set('n', '<leader>e', ':Lexplore<CR>', { desc = "Open file explorer" })


-------------------------------------------------------------------------------
-- ctrl+s: replace all words under cursor.
-- <c-r><c-w> to grab the word under cursor
-------------------------------------------------------------------------------
keymap.set('n',
    '<c-s>',
    ':%s/<C-r><C-w>//g<left><left>',
    { desc = "Replace all words under the cursor" })


-------------------------------------------------------------------------------
-- Split & window movement
-------------------------------------------------------------------------------

-- Vertical split
keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = "Vertical split" })

-- Move between windows
keymap.set('n', '<leader>h', ':wincmd h<CR>', {silent=true, desc = "Move to left window" })
keymap.set('n', '<leader>j', ':wincmd j<CR>', {silent=true, desc = "Move to down window" })
keymap.set('n', '<leader>k', ':wincmd k<CR>', {silent=true, desc = "Move to up window" })
keymap.set('n', '<leader>l', ':wincmd l<CR>', {silent=true, desc = "Move to right window" })
keymap.set('n', '<leader>q', ':wincmd q<CR>', {silent=true, desc = "Quit current window" })
keymap.set('n', '<C-h>', ':wincmd h<CR>', {silent=true, desc = "Move to left window" })
keymap.set('n', '<C-l>', ':wincmd l<CR>', {silent=true, desc = "Move to right window" })

-- Resize windows
keymap.set('n', '-', ':vertical resize -5<CR>', {silent=true, desc = "Decrease window size" })
keymap.set('n', '=', ':vertical resize +5<CR>', {silent=true, desc = "Increase window size" })
keymap.set('n', '|', '<C-w>=', {silent=true, desc = "Equal window size" })


--[[
-------------------------------------------------------------------------------
After make line selections:

shift+j: move selection down
shift+k: move selection up
<: left indent
>: right indent
--]]
keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap.set('v', '<', '<gv', { desc = "Left indent selections" })
keymap.set('v', '>', '>gv', { desc = "Right indent selections" })


-------------------------------------------------------------------------------
-- Basic searching improvement
-------------------------------------------------------------------------------

keymap.set('n', '<leader>n', ':nohl<CR>', { desc = "No highlight" })

keymap.set('n', 'n', 'nzz', { desc = "Jump to next matching and center" })
keymap.set('n', 'N', 'Nzz', { desc = "Jump to prev matching and center" })

-- Snippets (suggestion list) select item up and down
keymap.set('i', '<c-j>', '<c-n>')
keymap.set('i', '<c-k>', '<c-p>')

keymap.set('n', '<leader>oq', ':copen<CR>', { desc = "Open quick list" })
keymap.set('n', '<leader>cq', ':cclose<CR>', { desc = "Close quick list" })

keymap.set('n', '<leader>ol', ':lopen<CR>', { desc = "Open location list" })
keymap.set('n', '<leader>cl', ':lclose<CR>', { desc = "Close location list" })

-- Cycle through the quick fix list and center the current result line
keymap.set('n', '<c-j>', ':cnext<CR>zz')
keymap.set('n', '<c-k>', ':cNext<CR>zz')




-------------------------------------------------------------------------------
-- Rust related
-------------------------------------------------------------------------------
keymap.set('n',
    '<leader>cc',
    ':vsplit<CR>:terminal cargo check<CR>',
    { desc = "Rust: cargo check" })
keymap.set('n',
    '<leader>cb',
    ':vsplit<CR>:terminal cargo build --release<CR>',
    { desc = "Rust: cargo build --release" })
keymap.set('n',
    '<leader>cr',
    ':vsplit<CR>:terminal cargo run <CR>',
    { desc = "Rust: cargo run" })
keymap.set('n',
    '<leader>ct',
    ':vsplit<CR>:terminal cargo test<CR>',
    { desc = "Rust: cargo test" })


-------------------------------------------------------------------------------
-- Zig related
-------------------------------------------------------------------------------
keymap.set('n',
    '<leader>zr',
    ':vsplit<CR>:terminal zig build run<CR>',
    { desc = "Zig: zig build run" })


-------------------------------------------------------------------------------
-- <leader>sc: Toggle spell checking
-------------------------------------------------------------------------------
function is_enabled_spell()
    -- vim.wo.spell = !vim.wo.spell
    if vim.wo.spell == true then vim.wo.spell = false
    else vim.wo.spell = true
    end
end

keymap.set('n',
    '<leader>sc',
    '<cmd>lua is_enabled_spell()<CR>',
    { desc = "Toggle spell checking" })


-------------------------------------------------------------------------------
-- Handy book marks
-------------------------------------------------------------------------------

-- `mm`: Make a gloabl mark
keymap.set('n', 'mm', 'mM', { desc = "Mark current position" })

-- `gb`: Go back to the global mark
keymap.set('n', 'gb', '`Mzz', { desc = "Go back to last marked position" })


-------------------------------------------------------------------------------
-- Tab related
-------------------------------------------------------------------------------
keymap.set('n',
    '<leader>to',
    '<cmd>tabnew<CR>',
    { desc = "Tab: open new tab" }
)
keymap.set('n',
    '<leader>tc',
    '<cmd>tabclose<CR>',
    { desc = "Tab: close current tab" }
)
keymap.set('n',
    '<leader>tn',
    '<cmd>tabn<CR>',
    { desc = "Tab: go to next tab" }
)
keymap.set('n',
    '<leader>tp',
    '<cmd>tabp<CR>',
    { desc = "Tab: go to prev tab" }
)
keymap.set('n',
    '<leader>tf',
    '<cmd>tabnew %<CR>',
    { desc = "Tab: open current buffer in new tab" }
)


-------------------------------------------------------------------------------
-- Terminal related
-------------------------------------------------------------------------------
keymap.set('n',
    '<leader>ot',
    ':vsplit<CR>:terminal<CR>',
    { desc = "Terminal: open terminal" }
)

keymap.set('t',
    '<ESC>',
    '<C-\\><C-n>',
    { desc = "Terminal: Press `<ESC>` to back to normal mode" }
)

keymap.set('t',
    '<C-h>',
    '<C-\\><C-n><C-w>h',
    { desc = "Terminal: Press `<C-h>` to go back to the left window" }
)


-------------------------------------------------------------------------------
-- Window utils
-------------------------------------------------------------------------------
vim.keymap.set(
    "n",
    "<leader>1",
    "<cmd>lua require('my_window_utils').kill_other_windows()<CR>",
    {
        silent = true,
        desc = "Kill other windows"
    }
)
