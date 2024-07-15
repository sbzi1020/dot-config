--
-- Functions that let `nvim-cmp` work with `hrsh7th/vim-vsnip` when press `tab`
--
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


return {
    -- A completion engine plugin for neovim written in Lua.
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- nvim-cmp source for neovim's built-in language server client.
        'hrsh7th/cmp-nvim-lsp',
        -- nvim-cmp source for neovim Lua API.
        'hrsh7th/cmp-nvim-lua',
        -- nvim-cmp source for buffer words.
        'hrsh7th/cmp-buffer',
        -- nvim-cmp source for filesystem paths.
        'hrsh7th/cmp-path',
        -- nvim-cmp source for vim's cmdline.
        'hrsh7th/cmp-cmdline',

        -- Snippet,
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
    },
    config = function()
        vim.cmd('let g:vsnip_snippet_dir = expand(\'~/.config/nvim/snippets\')')


        ---
        --- 'nvim-cmp' setup
        ---
        local cmp = Reload_package('cmp')
        cmp.setup({
            -- If the item has preselect = true, nvim-cmp will preselect it.
            -- `cmp.PreselectMode.Item` is the default setting.
            preselect = cmp.PreselectMode.Item,

            --
            -- Complection menu config
            --
            completion = {
                --
                -- `menuone`: Still show popup menu when there is only one item.
                -- `preview`: Show extra info in preview window.
                -- `noselect`: Do not select by defualt.
                --
                -- Run the following commands to know more about it:
                --
                -- `:h completeopt`
                -- `require('telescope.builtin').help_tags()`,
                --
                completeopt = "menu,menuone,preview,noselect",
            },

            --
            -- REQUIRED - you must specify a snippet engine
            --
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
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
                ['<C-e>'] = cmp.mapping.abort(),

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

            -- -- Customize the item formatting
            -- formatting = {
            --     format = function(entry, vim_item)
            --         -- Item rendering: icon, kind name
            --         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)

            --         -- Clear style: Do not display the icon and kind name!!!
            --         vim_item.kind = ""

            --         -- Source name mapping
            --         vim_item.menu = ({
            --             nvim_lua = "[Lua]",
            --             path = "[Path]",
            --             nvim_lsp = "[LSP]",
            --             vsnip = "[Snippets]",
            --             buffer = "[Buffer]",
            --             latex_symbols = "[LaTeX]",
            --         })[entry.source.name]
            --         return vim_item
            --     end
            -- },

            -- Floating document window use rounded border
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })
        })


        vim.keymap.set('n',
            '<leader>os',
            '<cmd>vs ~/.config/nvim/snippets<CR>',
            {
                silent = true,
                desc = "Open snippets folder",
            })
    end
}
