--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
--------------------------------------------------------------------------
-- general
--------------------------------------------------------------------------
-- lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "pinkgirl"



-- lvim.builtin.lualine.style = 'lvim'
-- no need to set style = "lvim"
-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = false

-- status line
lvim.builtin.lualine.sections.lualine_a = { "mode" }
lvim.builtin.lualine.sections.lualine_b = { 'branch', 'diff', 'diagnostics' }
lvim.builtin.lualine.sections.lualine_c = { 'filename' }
lvim.builtin.lualine.sections.lualine_x = { 'encoding', 'fileformat', 'filetype' }
lvim.builtin.lualine.sections.lualine_y = { 'progress' }
lvim.builtin.lualine.sections.lualine_z = { 'location' }

--------------------------------------------------------------------------

vim.opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4 -- insert 2 spaces for a tab

-- vim.opt.backup = false -- creates a backup file
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
vim.opt.colorcolumn = "99999" -- fixes indentline for now
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0 -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.foldmethod = "manual" -- folding set to "expr" for treesitter based folding
vim.opt.foldexpr = "" -- set to "nvim_treesitter#foldexpr()" for treesitter based folding
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = true -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.pumheight = 10 -- pop up menu height
vim.opt.showmode = true -- we don't need to see things like -- INSERT -- anymore
-- vim.opt.showtabline = 2 -- always show tabs
vim.opt.smartcase = true -- smart case
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.splitbelow = true -- force all horizontal splits to go below current window
vim.opt.splitright = true -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false -- creates a swapfile
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 300 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.title = true -- set the title of window to the value of the titlestring
vim.opt.titlestring = "%<%F%=%l/%L - nvim" -- what the title of the window will be set to
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 300 -- faster completion
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.cursorline = true -- highlight the current line
vim.opt.cursorlineopt = "both"
vim.opt.number = true -- set numbered lines
vim.opt.relativenumber = true -- set relative numbered lines
vim.opt.numberwidth = 2 -- set number column width to 2 {default 4}
-- vim.opt.signcolumn = "yes" -- always show the sign column otherwise it would shift the text each time
vim.opt.wrap = false -- display lines as one long line
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.scrolloff = 8 -- is one of my fav
vim.opt.sidescrolloff = 8

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
vim.keymap.set("i", "jj", "<ESC>")


--vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'W', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'Q', ':q<CR>', { noremap = true, silent = true })
--------------------------------------------------------------------------
-- Movement
--------------------------------------------------------------------------
vim.api.nvim_set_keymap('n', 'm', 'h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'n', 'j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'e', 'k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'i', 'l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'm', 'h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'n', 'j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'e', 'k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'i', 'l', { noremap = true, silent = true })
--------------------------------------------------------------------------
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
vim.api.nvim_set_keymap('v', 'N', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'E', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-----------------------------------------------------------------------
vim.api.nvim_set_keymap('n', 'l', 'i', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', 'I', { noremap = true, silent = true })
--
vim.api.nvim_set_keymap('n', 'Y', 'y$', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', 'cc', 'ci', { noremap = true, silent = true })

-- H and L instead of '^' and '$'
vim.api.nvim_set_keymap('n', 'M', '^', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'I', '$', { noremap = true, silent = true })

-- between quote
vim.api.nvim_set_keymap('n', 'J', '{', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '}', { noremap = true, silent = true })

-- <Tab> and shift+<Tab> to cycle through the opened buffers
vim.api.nvim_set_keymap('n', '<Tab>', ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bp<CR>', { noremap = true, silent = true })

-- <leader><leader>: toggles between buffers
vim.api.nvim_set_keymap('n', '<leader><leader>', '<c-^>', { noremap = true, silent = true })

-- ctrl+s: replace all works under cursor. Do a `/pattern` which the `pattern`
-- is the word under cursor.
vim.api.nvim_set_keymap('n', '<c-s>', ':%s/<C-r><C-w>//g<left><left>', { noremap = true, silent = true })

-- Resize windows
vim.api.nvim_set_keymap('n', '-', ':vertical resize -5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '+', ':vertical resize +5<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '=', '<C-w>=', { silent = true })

-- Search results center jump
vim.api.nvim_set_keymap('n', 'h', 'nzz', { silent = true })
vim.api.nvim_set_keymap('n', 'H', 'Nzz', { silent = true })

-------------------------------------------------------------------------------------------
-- Customize the `<leader>` pane
-- Pay attention, all keybindings that start with `<leader>`, you have to
-- use the `which_key` way to bind the key!!!
-------------------------------------------------------------------------------------------
-- arrays action of `x`
lvim.builtin.which_key.mappings["x"] = {
    name = "+fion",
    x = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "fix" },
}
-- single action of `/`
lvim.builtin.which_key.mappings["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment" }
-- Find in open buffers
lvim.builtin.which_key.mappings["b"] = { "<cmd>Telescope buffers<CR>", "Open Buffers" }

-- Help search by in Telescope
lvim.builtin.which_key.mappings["h"] = { "<cmd>Telescope help_tags<CR>", "Help" }

--lvim.builtin.which_key.mappings["f"] = { ":lua require('telescope.builtin').live_grep({prompt_title='Search in project', prompt_prefix='  ', shorten_path=true})<CR>",
--"Telescope Live Grep" }

-- <leader>n: Close highlight
lvim.builtin.which_key.mappings["n"] = { ":nohl<CR>", "No Highlight" }

-- Vertical split
lvim.builtin.which_key.mappings["vs"] = { ":vsplit<CR>", "split window" }




-----------------------------------------------------------------------------
-- Telescope
-----------------------------------------------------------------------------
local _, actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings = {
    -- for input mode
    i = {
        -- Cokemak
        ["<C-n>"] = actions.move_selection_next,
        ["<C-e>"] = actions.move_selection_previous,

        ["<C-h>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,
    },
    -- for normal mode
    n = {
        -- Cokemak
        ["<C-n>"] = actions.move_selection_next,
        ["<C-e>"] = actions.move_selection_previous,
    },
}
lvim.builtin.telescope.defaults.layout_config = {

    -- Popup window settings
    width = 0.90,

    -- Prompt (Search bar) position
    prompt_position = "top",

    -- layout_strategy = "flex",
    horizontal = {
        -- The width of preview window
        preview_width = 0.45,

        -- If set to `true`, then swap `result list` and `preview window`
        mirror = false,
    }
}
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["p"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
}

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

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
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
    "sumeko_lua",
    "jsonls",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"

-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. !!Requires `:LvimCacheReset` to take effect!!
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
-- local formatters = require "lvim.lsp.null-ls.formatters"
-- formatters.setup {
--     -- { command = "black", filetypes = { "python" } },
--     -- { command = "isort", filetypes = { "python" } },
--     {
--         --     -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--         command = "prettier",
--         --     ---@usage arguments to pass to the formatter
--         --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--         extra_args = { "--print-with", "100" },
--         --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--         filetypes = { "typescript", "typescriptreact" },
--     },
-- }


local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
    {
        command = "proselint",
        args = { "--json" },
        filetypes = { "markdown", "tex" },
    },
}
-- -- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    -- { command = "flake8", filetypes = { "python" } },
    {
        --     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
        command = "shellcheck",
        --     ---@usage arguments to pass to the formatter
        --     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
        extra_args = { "--severity", "warning" },
    },
    {
        command = "codespell",
        --     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
        filetypes = { "javascript", "python" },
    },
}

-- Additional Plugins
-- lvim.plugins = {
--     {"folke/tokyonight.nvim"},
--     {
--       "folke/trouble.nvim",
--       cmd = "TroubleToggle",
--     },
-- }

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.json", "*.jsonc" },
--   -- enable wrap mode for json files only
--   command = "setlocal wrap",
-- })
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.cmd 'hi CursorLine guifg=NONE guibg=#424141 ctermbg=NONE gui=NONE cterm=NONE'
    end,
})

-------------------------------------------------------------------------
-- Snippets
-------------------------------------------------------------------------
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets/vscode-es7-javascript-react-snippets" } }
require("luasnip/loaders/from_vscode").load { paths = { "~/.config/lvim/snippets/my-snippets" } }

-- Solid background
-- vim.cmd 'hi CursorLine guifg=NONE guibg=#424141 ctermbg=NONE gui=NONE cterm=NONE'
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
