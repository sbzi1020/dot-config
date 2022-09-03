if vim.g.enable_vim_debug then print "'my_treesitter' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
nvim-treesitter

1. Install langauge parsers:

:TSInstall fish
:TSInstall toml
:TSInstall lua
:TSInstall rust
:TSInstall typescript
:TSInstall tsx
:TSInstall cmake
:TSInstall html
:TSInstall css
:TSInstall json

After that, all compiled language parsers will be placed into:
~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/parser/{LANGUAGE_NAME}.so

You can run `:TSInstallInfo` to show all language parers status


2. Enable the builtin modules:

All modules (highlighting, indentation, or folding) are disabled by
default. You need to enable them like the module config below. And you
can run `:TSModuleInfo` to show all modules status (for the particular
filetype).

Run `:h nvim-treesitter-modules` show all settings when needed.
-----------------------------------------------------------------------
--]]
local loaded_package = Reload_package( "nvim-treesitter.configs")
--print(vim.inspect(loaded_package))

loaded_package.setup({
    -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    ensure_installed = {
        "fish",
        "toml",
        "lua",
        "rust",
        "typescript",
        "tsx",
        "cmake",
        "html",
        "css",
        "json",
        "query",
    },

    -- install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- List of parsers to ignore installing
    ignore_install = { "" },
    autopairs = {
        enable = true,
    },
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,
    },
    indent = { enable = true, disable = { "yaml" } },
    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },
    playground = {
        enable = true,
        disable = {},
        updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
        persist_queries = false, -- Whether the query persists across vim sessions
    },
})
