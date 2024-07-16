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
        -- print(">>> nvim-lspconfig module loaded")
        local lspconfig = require('lspconfig')
        local mason_lspconfig = require("mason-lspconfig")
        local cmp_nvim_lsp = require('cmp_nvim_lsp')

        --
        -- Add local buffer keybindings when LSP client attached to the opened
        -- buffer
        --
        vim.api.nvim_create_autocmd('LspAttach', {
            --
            -- group (string|integer) optional: autocommand group name or id to
            -- match against.
            --
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),

            --
            -- callback to be executed when 'LspAttach' event happens
            --
            -- `event` param : {
            --   • id: (number) autocommand id
            --   • event: (string) name of the triggered event
            --     |autocmd-events|
            --   • group: (number|nil) autocommand group id, if any
            --   • match: (string) expanded value of <amatch>
            --   • buf: (number) expanded value of <abuf>
            --   • file: (string) expanded value of <afile>
            --   • data: (any) arbitrary data passed from
            -- }
            --
            callback = function(event)
                -- print(">>> LspAttach callback, event: "..vim.inspect(event))
                local keybinding_opts = {
                    -- Only bind to the attached buffer (local binding)
                    buffer = event.buf,
                    silent = true,
                    desc = "",
                }

                ---------------------------------------------------------------
                -- Set LSP keybindings
                ---------------------------------------------------------------
                keybinding_opts.desc = "LSP: Go to definition"
                vim.keymap.set('n',
                    'gd',
                    -- '<cmd>lua vim.lsp.buf.definition()<CR>',
                    '<cmd>Telescope lsp_definitions<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to declaration"
                vim.keymap.set('n',
                    'gD',
                    '<cmd>lua vim.lsp.buf.declaration()<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to type definition"
                vim.keymap.set('n',
                    'gt',
                    '<cmd>Telescope lsp_type_definitions<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to references"
                vim.keymap.set('n',
                    'gr',
                    -- '<cmd>lua vim.lsp.buf.references()<CR>',
                    '<cmd>Telescope lsp_references<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to implementation"
                vim.keymap.set('n',
                    'gi',
                    --'<cmd>lua vim.lsp.buf.implementation()<CR>',
                    '<cmd>Telescope lsp_implementations<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Format"
                vim.keymap.set("n",
                    "<leader>ff",
                    "<cmd>lua vim.lsp.buf.format( {async = true} )<CR>",
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Show documentation"
                vim.keymap.set('n',
                    'K',
                    '<cmd>lua vim.lsp.buf.hover()<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Rename"
                vim.keymap.set('n',
                    'rn',
                    '<cmd>lua vim.lsp.buf.rename()<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Show Errors"
                vim.keymap.set('n',
                    'se',
                    '<cmd>Telescope diagnostics<CR>',
                    -- ' <cmd>lua vim.diagnostic.setloclist()<CR>'
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to next diagnostic"
                vim.keymap.set('n',
                    '<c-n>',
                    '<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = \'rounded\'}})<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Go to prev diagnostic"
                vim.keymap.set('n',
                    '<c-p>',
                    '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = \'rounded\'}})<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Code actions"
                vim.keymap.set('n',
                    'ca',
                    '<cmd>lua vim.lsp.buf.code_action()<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "LSP: Code action - Quick fix"
                vim.keymap.set('n',
                    'qf',
                    '<cmd>lua vim.lsp.buf.code_action({only = \'quickfix\'})<CR>',
                    keybinding_opts)
            end
        })


        ---------------------------------------------------------------
        -- Customize diagnostic symbol column icons
        -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
        --
        -- For more highlight group, plz search help

        -- `:h diagnostic-highlights`
        -- `:h diagnostic-signs`
        ---------------------------------------------------------------
        local signs = { Error = "󰅙 ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end


        ---------------------------------------------------------------
        --- lspconfig UI customization
        --- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
        ---------------------------------------------------------------
        -- lspconfig.


        ---------------------------------------------------------------
        --- :h mason-lspconfig.setup_handlers
        ---------------------------------------------------------------

        -- Get the default LSP's capabilities to advertise it to LSP servers.
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local lsp_handlers = {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function (server_name) -- default handler (optional)
                lspconfig[server_name].setup({
                    capabilities = capabilities,
                })
            end,

            --
            -- The above function is the default LSP server handler (its
            -- `setup` function will be called when LSP client attached
            -- to the opened buffer)
            --
            -- From here, place your specific LSP server hanlders to
            -- override the above default LSP handler.
            --
            --
            -- Read here about the lspconfig[server].setup({}):
            --
            -- https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-{}
            --
            ["rust_analyzer"] = function ()
                lspconfig["rust-analyzer"].setup({
                    capabilities = capabilities,
                })
            end,

            ["clangd"] = function ()
                lspconfig["clangd"].setup({
                    capabilities = capabilities,
                })
            end,

            ["zls"] = function ()
                lspconfig["zls"].setup({
                    capabilities = capabilities,
                })
            end,

            ["tsserver"] = function ()
                lspconfig["tsserver"].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern("package.json"),
                    init_options = {
                        lint = true,
                    },
                })
            end,

            ["denols"] = function ()
                lspconfig["denols"].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern("deno.json"),
                    init_options = {
                        lint = true,
                    },
                })
            end,

            ["lua_ls"] = function ()
                lspconfig["lua_ls"].setup {
                    capabilities = capabilities,
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" }
                            }
                        }
                    }
                }
            end,
        }

        mason_lspconfig.setup_handlers(lsp_handlers)
   end
}
