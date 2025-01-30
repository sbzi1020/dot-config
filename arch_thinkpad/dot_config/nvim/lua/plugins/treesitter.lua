return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    -- build = ":TSUpdate",
    build = function()
        require("nvim-treesitter.install").update({
            with_sync = true
        })()
    end,
    config = function()
        require('nvim-treesitter.configs').setup({
            -- A list of parser names, or "all" (the listed parsers MUST always be installed)
            ensure_installed = {
                "bash",
                "fish",
                "toml",
                "lua",
                "rust",
                "javascript",
                "typescript",
                "tsx",
                "cmake",
                "html",
                "css",
                "json",
                "query",
                "markdown",
                "cpp",
                "c",
                "make",
                "dockerfile",
                "proto",
                "vim",
                "yaml",
                "zig",
                "hare",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = false,

            -- List of parsers to ignore installing (or "all")
            -- ignore_install = { "javascript" },

            highlight = {
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true, },
            -- context_commentstring = {
            --     enable = true,
            --     enable_autocmd = false,
            -- },
            -- playground = {
            --     enable = true,
            --     disable = {},
            --     updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            --     persist_queries = false, -- Whether the query persists across vim sessions
            -- },
        })
    end
}
