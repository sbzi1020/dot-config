return {
    "neovim/nvim-lspconfig",
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- nvim-cmp source for neovim's built-in language server client.
        'hrsh7th/cmp-nvim-lsp',

        -- Neovim setup for init.lua and plugin development with full
        -- signature help, docs and completion for the nvim lua API.
        'folke/neodev.nvim',
    },

    --
    -- https://github.com/neovim/nvim-lspconfig
    --
    config = function()
        --[[ local lspconfig = require('lspconfig')
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require("cmp-nvim-lsp") ]]

    end
}
