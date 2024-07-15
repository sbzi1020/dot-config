--[[
-- `mason.nvim` is a Neovim plugin that allows you to easily manage external
-- editor tooling such as LSP servers, DAP servers, linters, and formatters
-- through a single interface.
--]]

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        --[[
        -- Install LSP server automatically, make sure you've installed the
        -- following programs as binary dependencies:
        --
        -- doas pacman --sync --refresh unzip icu npm
        --
        --]]
        require("mason-lspconfig").setup {
            --
            -- Pre-install the following language servers, fully support list:
            -- https://github.com/williamboman/mason-lspconfig.nvim
            --
            --
            -- LSP server installed location: ~/.local/share/nvim/mason/bin
            --
            ensure_installed = {
                "lua_ls",
                "bashls",
                "tsserver",
                "denols",
                "tailwindcss",
                "cssls",
                "html",
                "pyright",
                "clangd",
                "zls",
            },
        }
    end
}
