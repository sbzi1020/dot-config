return {
    "neovim/nvim-lspconfig",
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        -- nvim-cmp source for neovim's built-in language server client.
        'hrsh7th/cmp-nvim-lsp',

        -- lazydev.nvim setup `lua_ls` for you to make Neovim API LSP works.
        {
            "folke/lazydev.nvim",
            ft = "lua", -- only load on lua files
            opts = {
                library = {
                    -- See the configuration section for more details
                    -- Load luvit types when the `vim.uv` word is found
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            },
        },
        { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
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
        -- Customize diagnostic symbol column icons (the left sign
        -- column before the relative column!!!)
        --
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


        -----------------------------------------------------------------------
        -- Customize diagnostic virtual text
        --
        -- :h vim.diagnostic.config()
        -----------------------------------------------------------------------
        local config = {
            -- Virtual text
            underline = true,
            virtual_text = {
                -- prefix = "•",
                prefix = "",
                -- prefix = "",
                -- prefix = "",
                -- prefix = "■ ",
                spacing = 4,
            },

            -- show signs
            signs = {
                active = signs,
            },

            update_in_insert = true,
            severity_sort = true,
            float = {
                style = "minimal",

                --
                -- • "none": No border (default).
                -- • "single": A single line box.
                -- • "double": A double line box.
                -- • "rounded": Like "single", but with rounded corners
                --   ("╭" etc.).
                -- • "solid": Adds padding by a single whitespace cell.
                -- • "shadow": A drop shadow effect by blending with the
                --   background.
                -- • If it is an array, it should have a length of eight or
                --   any divisor of eight. The array will specify the eight
                --   chars building up the border in a clockwise fashion
                --   starting with the top-left corner. As an example, the
                --   double box style could be specified as: >
                --   [ "╔", "═" ,"╗", "║", "╝", "═", "╚", "║" ].
                border = "rounded",

                source = "always",
                header = "",
                prefix = "",
            },
        }

        vim.diagnostic.config(config)


        -----------------------------------------------------------------------
        -- rounded board for LSP documentation window
        -----------------------------------------------------------------------
        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
            vim.lsp.handlers.hover,
            { border = 'rounded' }
        )

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = 'rounded' }
        )


        ---------------------------------------------------------------
        ---
        --- :h mason-lspconfig.setup_handlers
        ---
        --- :h lspconfig-setup
        ---
        ---------------------------------------------------------------

        -- Get the default LSP's capabilities to advertise it to LSP servers.
        local capabilities = cmp_nvim_lsp.default_capabilities()

        local lsp_handlers = {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler (optional)
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
            ["tsserver"] = function()
                --
                -- :h lspconfig-setup
                -- :h vim.lsp.ClientConfig
                --
                lspconfig["tsserver"].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern("package.json"),
                    init_options = {
                        lint = true,
                    },
                    -- cmd = {'tsserver', 'param1', 'param2'}

                    --
                    -- The `settings` table is sent after initialization via a
                    -- `workspace/didChangeConfiguration` notification from the
                    -- Nvim client to the language server.
                    -- These settings allow a user to change optional runtime
                    -- settings of the language server.
                    --
                    -- settings = {}
                })
            end,

            ["denols"] = function()
                lspconfig["denols"].setup({
                    capabilities = capabilities,
                    root_dir = lspconfig.util.root_pattern("deno.json"),
                    init_options = {
                        lint = true,
                    },
                })
            end,
            ["rust_analyzer"] = function()
                lspconfig["rust-analyzer"].setup({
                    capabilities = capabilities,
                })
            end,

            ["clangd"] = function()
                lspconfig["clangd"].setup({
                    capabilities = capabilities,
                })
            end,

            ["zls"] = function()
                lspconfig["zls"].setup({
                    capabilities = capabilities,
                })
            end,


            ["lua_ls"] = function()
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
