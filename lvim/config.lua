--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
--------------------------------------------------------------------------
-------------
-- general
-------------
--------------------------------------------------------------------------
-- lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "pinkgirl"
lvim.transparent_window = true

-- lvim.builtin.lualine.style = 'lvim'
-- no need to set style = "lvim"
-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true

-- status line
lvim.builtin.lualine.style = "default"
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = { 'branch', 'diff', 'diagnostics' }
lvim.builtin.lualine.sections.lualine_c = { 'filename', 'spaces' }
lvim.builtin.lualine.sections.lualine_x = { 'encoding', 'fileformat', 'filetype' }
lvim.builtin.lualine.sections.lualine_y = { 'progress' }
lvim.builtin.lualine.sections.lualine_z = { 'location' }

--------------------------------------------------------------------------

vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4                             -- insert 2 spaces for a tab
-- vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1                           -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999"                   -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.foldmethod = "manual"                   -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.hidden = true                           -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.pumheight = 20                          -- pop up menu height
vim.opt.showmode = true                         -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 4                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true                            -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim"      -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.updatetime = 300                        -- faster completion
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.cursorline = false                      -- highlight the current line
vim.opt.cursorlineopt = "both"
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 2                         -- set number column width to 2 {default 4}
-- vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = true                             -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

--------------------------------------------------------------------------
-----------------
-- Key binding
-----------------
--------------------------------------------------------------------------

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
vim.keymap.set("i", "jj", "<ESC>")


-- Open float terminal
-- lvim.builtin.terminal.open_mapping = "<c-t>"

-- lvim.keys.normal_mode["m"] = false
-- `mm`: Make a gloabl mark
-- vim.api.nvim_set_keymap('n', 'kk', 'mM', { silent = true })
-- `gb`: Go back to the global mark
-- vim.api.nvim_set_keymap('n', 'vv', 'Mzz', { silent = true })

--vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', { noremap = true, silent = true })
-- Search results center jump
vim.api.nvim_set_keymap('n', '<c-[>', 'Nzz', { silent = true })
--------------------------------------------------------------------------
-- Movement
--------------------------------------------------------------------------
--vim.api.nvim_set_keymap('n', 'm', 'h', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'n', 'j', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'e', 'k', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'i', 'l', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', 'm', 'h', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', 'n', 'j', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', 'e', 'k', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('v', 'i', 'l', { noremap = true, silent = true })
--------------------------------------------
-----------------------------------------------------------------------
-- Block and line movement
-----------------------------------------------------------------------
-- Visual Mode: Select and cursor enhancement
-- After make selection on lines:
-- shift+j: move selection down
-- shift+k: move selection up
-- <: move selection to left with one tab distance
-- >: move selection to right with one tab distance
--
-- vim.api.nvim_set_keymap('v', 'N', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', 'E', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-----------------------------------------------------------------------
--vim.api.nvim_set_keymap('n', 'l', 'i', { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', 'L', 'I', { noremap = true, silent = true })
--
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'cc', 'ci', { noremap = true, silent = true })

-----------------------------------------------------------------------
-- H and L instead of '^' and '$'
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true, silent = true })

-----------------------------------------------------------------------
-- between quote/paragraph
-- vim.api.nvim_set_keymap('n', 'J', '{', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', 'K', '}', { noremap = true, silent = true })

-----------------------------------------------------------------------
-- <Tab> and shift+<Tab> to cycle through the opened buffers
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })

-----------------------------------------------------------------------
-- ctrl+s: replace all works under cursor. Do a `/pattern` which the `pattern`
-- is the word under cursor.
-- vim.api.nvim_set_keymap('n', '<c-s>', ':%s/<C-r><C-w>//g<left><left>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-s>', ':%s/<C-r><C-w>//g<left><left>', { noremap = true, silent = true })
--
-- Resize windows
vim.api.nvim_set_keymap('n', '-', ':vertical resize -5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '=', ':vertical resize +5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '|', '<C-w>=', { silent = true })


-- move up and down window
vim.api.nvim_set_keymap('n', '<C-j>', ':wincmd k<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':wincmd j<CR>', { silent = true })
--
-- open terminal
vim.api.nvim_set_keymap('n', '<C-t>', ':ToggleTerm size=20 direction=horizontal<CR>', { silent = true })
--
--
-- Centers cursor when moving 1/2 page down
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"

-- shift+J enter documentation puffer
lvim.lsp.buffer_mappings.normal_mode['K'] = { vim.lsp.buf.hover, "Show documentation" }
--
--
--
-- open diagnostic buffer
vim.api.nvim_set_keymap('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = \'rounded\'}})<CR>',
    { silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = \'rounded\'}})<CR>',
    { silent = true })
-------------------------------------------------------------------------------------------
------------------------
-- Customize the `<leader>` pane
-----------------------
-------------------------------------------------------------------------------------------
-- Use which-key to add extra bindings with the leader-key prefix
-- Pay attention, all keybindings that start with `<leader>`, you have to
-- use the `which_key` way to bind the key!!!
--------------------------------------------------------------------------------
-- arrays action of `x`
-- lvim.builtin.which_key.mappings["x"] = {
--     name = "+fion",
--     x = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "fix" },
-- }

lvim.builtin.which_key.mappings['/'] = {}
-- lvim.builtin.which_key.mappings[';'] = {}
lvim.builtin.which_key.mappings['q'] = {}
lvim.builtin.which_key.mappings['w'] = {}
lvim.builtin.which_key.mappings['T'] = {}
lvim.builtin.which_key.mappings['t'] = {} -- Trouble
lvim.builtin.which_key.mappings['d'] = {} -- Debug
lvim.builtin.which_key.mappings['g'] = {} -- git
--
-- comment
lvim.builtin.which_key.mappings["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" }
-- Find in open buffers
lvim.builtin.which_key.mappings["b"] = { "<cmd>Telescope buffers<CR>", "Open Buffers" }

-- Help search by in Telescope
lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope help_tags<CR>", "Help" }

-- <leader>n: Close highlight
lvim.builtin.which_key.mappings["n"] = { ":nohl<CR>", "No Highlight" }

-- Vertical split window
lvim.builtin.which_key.mappings["v"] = { ":vsplit<CR>", "split window" }

-- move focus window
lvim.builtin.which_key.mappings["m"] = { ":wincmd h<CR>", "move focus window" }
lvim.builtin.which_key.mappings["i"] = { ":wincmd l<CR>", "move back window" }
--lvim.builtin.which_key.mappings["j"] = { ":wincmd j<CR>", "move down window" }
-- lvim.builtin.which_key.mappings["k"] = { ":wincmd k<CR>", "move up window" }

-- QuickFix
lvim.builtin.which_key.mappings["x"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "fix" }

-- telescope projects
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- terminal
-- lvim.builtin.which_key.mappings["t"] = { ":ToggleTerm size=20 direction=horizontal<CR>", "terminal" }

-- lvim.builtin.which_key.mappings["d"] = { "<cmd>TroubleToggle<cr>", "diagnostics" }
-- trouble
-- lvim.builtin.which_key.mappings["d"] = {
--     name = "Diagnostics",
--     t = { "<cmd>TroubleToggle<cr>", "trouble" },
--     w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
--     d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
--     q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
--     l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
--     r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
-- }
--
-- Example:
-----------lvim.builtin.which_key.mappings["t"] = {
-- name = "Trouble",
-- r = { "<cmd>Trouble lsp_references<cr>", "References" },
-- f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
-- d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
-- q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
-- l = { "<cmd>Trouble loclist<cr>", "LocationList" },
-- w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
--}
-- goto-preview
--nnoremap gpd <cmd>lua require('goto-preview').goto_preview_definition()<CR>
-- nnoremap gpt <cmd>lua require('goto-preview').goto_preview_type_definition()<CR>
-- nnoremap gpi <cmd>lua require('goto-preview').goto_preview_implementation()<CR>
-- nnoremap gP <cmd>lua require('goto-preview').close_all_win()<CR>
-- nnoremap gpr <cmd>lua require('goto-preview').goto_preview_references()<CR>
--vim.keymap.set("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", {noremap=true})
lvim.builtin.which_key.mappings["g"] = {
    name = "preview",
    d = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "definition" },
    r = { "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "references" },
    c = { "<cmd>lua require('goto-preview').close_all_win()<CR>", "close" },
}
-----------------------------------------------------------------------------
------------
-- Telescope
------------
-----------------------------------------------------------------------------
-- key movement
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        -- Cokemak
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,

        ["<C-h>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        -- Cokemak
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        -- ["<C-a>"] = actions.,
    },
}
-----------------------------------------------------------------------------
-- layout
lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
lvim.builtin.telescope.defaults.layout_config = {
    -- Popup window settings
    width = 0.90,
    height = 0.90,

    -- Prompt (Search bar) position
    prompt_position = "top",

    -- layout_strategy = "flex",
    horizontal = {
        -- The width of preview window
        preview_width = 0.45,
        preview_height = 0.95,

        -- If set to `true`, then swap `result list` and `preview window`
        mirror = false,
    }
}

-----------------------------------------------------------------------------
------------
-- plugins: file explorer
------------
-----------------------------------------------------------------------------
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- lvim.builtin.notify.active = false
lvim.builtin.terminal.active = true
lvim.builtin.terminal.close_on_exit = true
lvim.builtin.terminal.auto_scroll = true
lvim.builtin.terminal.ToggleTermToggleAll = true


lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.width = 40
lvim.builtin.nvimtree.setup.view.number = true
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.renderer.indent_markers = {
    enable = true,
    inline_arrows = true,
    icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
    },
}

lvim.builtin.nvimtree.setup.view.mappings.list = {
    { key = "e", action = "" },
    { key = "m", action = "close_node" },
    { key = "i", action = "edit" },
    { key = "d", action = "remove" },
    { key = "O", action = "collapse_all" },
    -- default command
    -- `<C-v>`           vsplit              open the file in a vertical split
    -- `<C-t>`           tabnew              open the file in a new tab
    -- `P`               parent_node         move cursor to the parent directory
    -- `H`               toggle_dotfiles     toggle visibility of dotfiles via |filters.dotfiles| option
    -- `R`               refresh             refresh the tree
    -- `d`               remove              delete a file (will prompt for confirmation)
    -- `D`               trash               trash a file via |trash| option
    -- `r`               rename              rename a file
    -- `<C-r>`           full_rename         rename a file and omit the filename on input
    -- `e`               rename_basename     rename a file with filename-modifiers ':t:r' without changing extension
    -- `x`               cut                 add/remove file/directory to cut clipboard
    -- `c`               copy                add/remove file/directory to copy clipboard
    -- `p`               paste               paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation
    -- `y`               copy_name           copy name to system clipboard
    -- `Y`               copy_path           copy relative path to system clipboard
    -- `gy`              copy_absolute_path  copy absolute path to system clipboard
    -- `f`               live_filter         live filter nodes dynamically based on regex matching.
    -- `F`               clear_live_filter   clear live filter
    -- `S`               search_node         prompt the user to enter a path and then expands the tree to match the path
    -- `<C-k>`           toggle_file_info    toggle a popup with file infos about the file under the cursor
}


-----------------------------------------------------------------------------
------------
-- plugins: treesitter
------------
-----------------------------------------------------------------------------
-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
    "bash",
    "c",
    "javascript",
    "json",
    "lua",
    "python",
    "typescript",
    "tsx",
    "css",
    "rust",
    "java",
    "yaml",
    "html",
    "rust"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true
-- lvim.builtin.treesitter.incremental_selection.enable = true


--
-----------------------------------------------------------------------------
------------
-- generic LSP settings
------------
-----------------------------------------------------------------------------

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    "jsonls",
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "black" },
    {
        command = "prettier",
        args = { "--print-width", "100", "--tab-width", "4", "singleQuote", "true" },
        filetypes = { "typescript", "typescriptreact" },
    },
}

local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "flake8" },
    {
        command = "shellcheck",
        args = { "--severity", "warning" },
    },
    {
        command = "codespell",
        filetypes = { "javascript", "python" },
    },
}

local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        command = "proselint",
        args = { "--json" },
        filetypes = { "markdown", "tex" },
    },
}

---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
--
--[[
-- Snippets
--]]
require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" } })
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets/my-snippets" } }

-- vim.cmd('highlight Normal guibg=black')
-- vim.cmd 'hi CursorLine guifg=NONE guibg=#493d35'
-- vim.cmd 'hi CursorLine guifg=NONE guibg=#424141 ctermbg=NONE gui=NONE cterm=NONE'
--
--
lvim.builtin.alpha.active = false
lvim.builtin.alpha.mode = "dashboard"

lvim.plugins = {
    { "lunarvim/colorschemes" },
    --
    -- jump to the line
    {
        "nacro90/numb.nvim",
        event = "BufRead",
        config = function()
            require("numb").setup {
                show_numbers = true,    -- Enable 'number' for the window while peeking
                show_cursorline = true, -- Enable 'cursorline' for the window while peeking
            }
        end,
    },
    {
        "andymass/vim-matchup",
        event = "CursorMoved",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        version = '*',
        config = function()
            require("toggleterm").setup()
        end
    },
    {
        "tpope/vim-surround",

        -- make sure to change the value of `timeoutlen` if it's not triggering correctly, see https://github.com/tpope/vim-surround/issues/117
        config = function()
            vim.o.timeoutlen = 500
        end
    },
    { "tpope/vim-repeat" },
    {
        "ethanholz/nvim-lastplace",
        event = "BufRead",
        config = function()
            require("nvim-lastplace").setup({
                lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
                lastplace_ignore_filetype = {
                    "gitcommit", "gitrebase", "svn", "hgcommit",
                },
                lastplace_open_folds = true,
            })
        end,
    },
    {
        "folke/trouble.nvim",
        cmd = "TroubleToggle",
    },
    {
        "ahmedkhalf/lsp-rooter.nvim",
        event = "BufRead",
        config = function()
            require("lsp-rooter").setup()
        end,
    },
    {
        "rmagatti/goto-preview",
        config = function()
            require('goto-preview').setup {
                width = 100, -- Width of the floating window
                height = 40, -- Height of the floating window
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
                default_mappings = false, -- Bind default mappings
                resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                references = {
                    telescope = nil,
                },
                focus_on_open = true,                  -- Focus the floating window when opening it.
                dismiss_on_move = false,               -- Dismiss the floating window when moving the cursor.
                force_close = true,                    -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
                bufhidden = "wipe",                    -- the bufhidden option to set on the floating window. See :h bufhidden
                stack_floating_preview_windows = true, -- Whether to nest floating windows
            }
        end,
    },
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        event = "BufRead",
    },
}
