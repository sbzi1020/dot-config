if vim.g.enable_vim_debug then print "'my_lsp' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
LSP settings
-----------------------------------------------------------------------
--]]
local nvim_lsp = Reload_package('lspconfig')
local protocol = Reload_package('vim.lsp.protocol')


--local custom_lsp_attach = function(client, bufnr)
local custom_lsp_attach = function()
    --print "LSP client is connected"
    --print(vim.inspect(bufnr))
    --print(vim.inspect(client))

    --[[
    -----------------------------------------------------------------------
    Customize diagnostic symbol column icons
    For more highlight group, plz search help

    `:h diagnostic-highlights`
    `:h diagnostic-signs`
    -----------------------------------------------------------------------
    --]]
    local signs = {
        { name = "DiagnosticSignError", highlight_group = "LspDiagnosticsSignError", text = ""  },
        { name = "DiagnosticSignWarn",  highlight_group = "LspDiagnosticsSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  highlight_group = "LspDiagnosticsSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  highlight_group = "LspDiagnosticsSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.highlight_group, text = sign.text, numhl = "" })
    end


    --[[
    -----------------------------------------------------------------------
    Customize diagnostic virtual text
    -----------------------------------------------------------------------
    --]]
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
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)


    --[[
    -----------------------------------------------------------------------
    Customize floating window border

    Here is the optional `border` value you can choose which copied from
    `:h nvim_open_win`

        • `border`: Style of (optional) window border. This can either be a
           string or an array.

           - The string values are:
            • "none": No border (default).
            • "single": A single line box.
            • "double": A double line box.
            • "rounded": Like "single", but with rounded
                corners ("╭" etc.).
            • "solid": Adds padding by a single whitespace
                cell.
            • "shadow": A drop shadow effect by blending
                with the background.

           - Or like a table/object:

            local border = {
                {"╭", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╮", "FloatBorder"},
                {"│", "FloatBorder"},
                {"╯", "FloatBorder"},
                {"─", "FloatBorder"},
                {"╰", "FloatBorder"},
                {"│", "FloatBorder"},
            }

    -----------------------------------------------------------------------
    --]]
    -- local border = {
    --     {"╭", "FloatBorder"},
    --     {"─", "FloatBorder"},
    --     {"╮", "FloatBorder"},
    --     {"│", "FloatBorder"},
    --     {"╯", "FloatBorder"},
    --     {"─", "FloatBorder"},
    --     {"╰", "FloatBorder"},
    --     {"│", "FloatBorder"},
    -- }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        -- {border = 'single'}
        {border = 'rounded'}
        -- {border = 'double'}
        -- {border = border}

    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
    )


    --[[
    -----------------------------------------------------------------------
    Buffer scope LSP keybinding

    gd:         Go to definition
    gD:         Go to declaration
    gf:         Go to file
    gi:         Implementation
    gr:         List references in current buffer
    K:          Show hover info in floating window
    rn:         Rename symbols
    <leader>ff: Format code in async mode
    se:         Put all diagnostic(error/hint) info into location list
                `<leader>cl` to close it
    <leader>e:  Show diagnostic(error/hint) info in floating window
    <c-n>:      Go to next diagnostic
    <c-p>:      Go to prev diagnostic
    -----------------------------------------------------------------------
    --]]

    local mapping_options = { noremap=true, silent=true }
    vim.api.nvim_buf_set_keymap(0, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting()<CR>", mapping_options)
    -- vim.api.nvim_buf_set_keymap(0, "n", "<leader>ff", "<cmd>lua vim.lsp.buf.formatting({ tabSize = 4, insertSpaces = true })<CR>", mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'rn',  '<cmd>lua vim.lsp.buf.rename()<CR>', mapping_options)
    --vim.api.nvim_buf_set_keymap(0, 'n', 'se', '<cmd>lua vim.diagnostic.setloclist()<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'se', '<cmd>Telescope diagnostics<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-n>', '<cmd>lua vim.diagnostic.goto_next({popup_opts = {border = \'rounded\'}})<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', '<c-p>', '<cmd>lua vim.diagnostic.goto_prev({popup_opts = {border = \'rounded\'}})<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>qf',  '<cmd>lua vim.lsp.buf.code_action({only = \'quickfix\'})<CR>', mapping_options)
    vim.api.nvim_buf_set_keymap(0, 'n', 'ca',  '<cmd>lua vim.lsp.buf.code_action()<CR>', mapping_options)
end


-- Use `cmp_nvim_lsp` capabilities
local capabilities = Reload_package('cmp_nvim_lsp')
    .default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- complection sinppet support should be `true`!!!
-- print(vim.inspect(capabilities.textDocument.completion.completionItem.snippetSupport))


--[[
When using LSP in neovim, the regular process is like this:

1. You need to install the particular LSP server, like `tsserver, denols`, etc.

2. You need to tell neovim to setup/config when connected to the LSP server and
attached to the curret buffer. Keep that in mind: neovim is `LSP client`, it
sends message/request to connected LSP server to ask for LSP content as response.


```lua
--
-- You can find the particular LSP server name from here:
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--
Reload_package('lspconfig').LSP_SERVER_NAME_HERE.setup({

    --
    -- What need to setup when connected to LSP server and attached to the buffer,,
    -- for example:
    --
    -- * Floating window style
    -- * Diagnostic style
    -- * LSP related keybindings
    --
    on_attach = custom_lsp_attach,


    --
    -- LSP client (neovim side) ask LSP server and LSP server response and confirm
    -- what it can do:
    --
    -- * Hey, I want auto complection, can u do that? Yes, I can
    -- * Hey, I want symbol renaming, can u do that? Yes, I can
    -- * etc.
    --
    capabilities = capabilities,

    -- What to find the project root folder
    root_dir = nvim_lsp.util.root_pattern("package.json"),
})
```

--]]


--[[
Load the LSP server with above settings

Typescript LSP Server

    `npm install -g typescript typescript-language-server`
    By default, it supports the filetypes below:

    * javascript
    * javascriptreact
    * javascript.jsx
    * typescript
    * typescriptreact
    * typescript.tsx

For all LSP servers, check here:
https://microsoft.github.io/language-server-protocol/implementors/servers/
--]]
nvim_lsp.tsserver.setup({
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("package.json"),
    init_options = {
        lint = true,
    },
})


--[[
Deno LSP server

`brew install deno` or `cargo install deno`
--]]
nvim_lsp.denols.setup {
    on_attach = custom_lsp_attach,
    capabilities = capabilities,
    root_dir = nvim_lsp.util.root_pattern("deno.json"),
    init_options = {
        -- lint = true,
        lint = false,
    },
}


--[[
Rust LSP server

`brew install rust-analyzer`
--]]
local rust_package = Reload_package('rust-tools')
rust_package.setup({

    -- All configs below you can found at:
    -- https://github.com/simrat39/rust-tools.nvim

    -- rust-tools options
    tools = {
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,

        -- Whether to show hover actions inside the hover window
        -- This overrides the default hover handler
        hover_with_actions = false,

        -- callback to execute once rust-analyzer is done initializing the
        -- workspace.
		-- The callback receives one parameter indicating the `health` of the
        -- server: "ok" | "warning" | "error"
        on_initialized = function(result)
            print( ">>> 'rust-tools' initialization done, health status: "..result.health)
            --print('>>> healt: ' .. vim.inspect(health))
        end,

        -- These apply to the default RustSetInlayHints command
        inlay_hints = {

            -- wheter to show parameter hints with the inlay hints or not
            show_parameter_hints = false,

            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",

            -- prefix for all the other hints (type, chaining)
            -- other_hints_prefix = "=> ",
            other_hints_prefix = ">>> ",
        },
    },
    --
    -- rust-analyer options
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        on_attach = custom_lsp_attach,
        capabilities = capabilities,
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    enable = true,
                    command = "check",
                    extraArgs = { "--target-dir", "/tmp/rust-analyzer-check" },
                },
                --[[
                For using `tonic`:

                If you're using `rust-analyzer `we recommend you set
                "rust-analyzer.cargo.runBuildScripts": true
                to correctly load the generated code.
                --]]
                cargo = {
                    runBuildScripts = true,

                    --
                    -- This option passes `--all-features` to `cargo check`,
                    -- and make sure all code blocks inside any `#[cfg()]` are
                    -- checked. Then you're able to use any LSP functionality
                    -- for all those `#[cfg()]` code blocks.
                    --
                    -- But if you use `diagnostics.disabled = { "inactive-code" }`
                    -- to disable the `inactive-code` hints (as that's pretty
                    -- annoying), then all those unused `#[cfg()]` code blocks
                    -- are disabled wth the LSP functionality: You CANNNOT
                    -- `K` or `gd` etc.:)
                    --
                    allFeatures = true,
                },
                -- diagnostics = {
                --     -- Use to disale the unused `[#cfg()]` code block warnning.
                --     -- https://rust-analyzer.github.io/manual.html#inactive-code
                --     disabled = { "inactive-code" }
                -- },
            },
        },
    }
})



--[[

Install 'clangd' LSP server

Linux: `sudo pacman --sync --refresh llvm`

MacOS:
    `brew install llvm`

    After that, plz make sure add `/usr/local/opt/llvm/bin/` to your `$PATH`!!!

--]]
local cpp_package = Reload_package('clangd_extensions')
cpp_package.setup({
    server = {
        on_attach = custom_lsp_attach,
        capabilities = capabilities,
    },
    extensions = {
        autoSetHints = true,
    }
})


--[[
-----------------------------------------------------------------------
vsnip

Run `:VsnipOpenEdit` command on any file to edit the snippet template.
-----------------------------------------------------------------------
--]]
vim.cmd('let g:vsnip_snippet_dir = expand(\'~/.config/nvim/snippets\')')
--print(vim.g.vsnip_snippet_dir)


--[[
-----------------------------------------------------------------------
nvim-cmp settings

`:h comp`

https://github.com/hrsh7th/nvim-compe/blob/master/doc/compe.txt
-----------------------------------------------------------------------
--]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

--
-- Customize completion item icons
--
local kind_icons = {
    Text = '',
    Method = '',
    Function = 'ƒ',
    Constructor = '',
    Field = '識',
    Variable = '',
    Class = '',
    Interface = '蘒',
    Module = '',
    Property = '',
    Unit = '',
    Value = '',
    Enum = '練',
    Keyword = '',
    Snippet = '﬌',
    Color = '',
    File = '',
    Reference = '渚',
    Folder = '',
    EnumMember = '',
    Constant = '',
    Struct = '',
    Event = '',
    Operator = 'Ψ',
    TypeParameter = '',
}

--
-- Functions that let `nvim-cmp` work with `hrsh7th/vim-vsnip` when press `tab`
--
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


--
-- Setup `nvim-cmp`
--
local cmp = Reload_package('cmp')
cmp.setup({
    -- If the item has preselect = true, nvim-cmp will preselect it.
    -- `cmp.PreselectMode.Item` is the default setting.
    preselect = cmp.PreselectMode.Item,

    --
    -- Tell `nvim-cmp` to expand with `hrsh7th/vim-vsnip`
    --
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        end,
    },

    --
    -- Keybinding, usage:
    -- ['KEY_HERE'] = cmp.mapping(MAPPING_FUNCTION_HERE, MAPPING_MODE_HERE)
    --
    mapping = {
        -- Scroll up and down in the popup documentation
        ['<C-h>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
        ['<C-l>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),

        -- Close the popup
        ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),

        -- Ctrl-j and Ctrl-k move selection on completion menu
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior,
            select = true,
        }), { 'i', 'c' }),
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior,
            select = true,
        }), { 'i', 'c' }),

        -- Enter to accept the selected item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),

        -- `Tab` to go through placeholder in snippet mode
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"](1) == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            elseif has_words_before() then
                cmp.complete()
            else
                fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            end
        end, { "i", "s" }),
        },

    -- Completion source (the order decides the priority!!!)
    sources = cmp.config.sources({
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'vsnip' },
        { name = 'nvim_lsp', keyword_length = 2  },

        --
        -- For `buffer` source, I only want to see it after I type over 5
        -- characters, so I don't get too much noisy items in the completion
        -- list.
        --
        { name = 'buffer', keyword_length = 5 },
    }),

    -- Customize the item formatting
    formatting = {
        format = function(entry, vim_item)
            -- Item rendering: icon, kind name
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

            -- Clear style: Do not display the icon and kind name!!!
            vim_item.kind = ""

            -- Source name mapping
            vim_item.menu = ({
                nvim_lua = "[Lua]",
                path = "[Path]",
                nvim_lsp = "[LSP]",
                vsnip = "[Snippets]",
                buffer = "[Buffer]",
                latex_symbols = "[LaTeX]",
            })[entry.source.name]
            return vim_item
        end
    },

    -- experimental = {
    --     native_menu = false,
    --     -- ghost_text = true,
    --     -- ghost_text = { hl_group = 'LspDiagnosticsSignWarn' }
    -- },

    -- Floating document window use rounded border
    window = {
        documentation = {
            border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        },
    },
})

--
-- Setup `cmp-cmdline`, enable `/` search from buffer source
--
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})
