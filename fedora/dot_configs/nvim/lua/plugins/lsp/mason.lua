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
            --
            -- https://github.com/williamboman/mason-lspconfig.nvim
            -- https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins
            --
            -- LSP server installed location: ~/.local/share/nvim/mason/bin
            --
            -- But use the system-installed LSP server binary has higher priority!!!
            --
            -- For example, I've already install `~/my-shell/zig-nightly/zls` and
            -- mason installs `~/.local/share/nvim/mason/bin/zls`.
            --
            -- Tnen `vim.lsp.start_client()` searchs my `zls` from `$PATH` and starts
            -- it, you can use `:LspInfo` to confirm:
            --
            --   1 client(s) attached to this buffer: 
            --   
            --   Client: zls (id: 1, bufnr: [1])
            --   	filetypes:       zig, zir
            --   	autostart:       true
            --   	root directory:  /home/wison/zig/temp
            --   	cmd:             /home/wison/my-shell/zig-nightly/zls
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
                -- "clangd",
                "zls",
            },
        }
    end
}
