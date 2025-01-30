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
        local setup_opts = {}
        if (vim.uv.os_uname().sysname == "FreeBSD") then
            setup_opts = {
                --
                -- The following LSP servers can't be installed via `Mason`:
                -- clangd, lua_ls, zls
                --
                ensure_installed = {
                    "bashls",
                    "tsserver",
                    "tailwindcss",
                    "cssls",
                    "html",
                    "pyright",
                },
            }
        elseif (string.find(vim.uv.os_uname().version, "Alpine") ~= nil) then
            setup_opts = {
                --
                -- The following LSP servers can't be installed via `Mason`:
                -- clangd, denols
                --
                ensure_installed = {
                    "lua_ls",
                    "bashls",
                    "tsserver",
                    "tailwindcss",
                    "cssls",
                    "html",
                    "pyright",
                    "zls",
                },
            }
        else
            setup_opts = {
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

        require("mason-lspconfig").setup(setup_opts)
    end
}
