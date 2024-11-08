-------------------------------------------------------------------------------
-- Neorg (Neovim org mode), learn how to use it:
--
-- `:h neorg`
-- Then run command `Neorg toc` to open navigation `Table Of Content`
-------------------------------------------------------------------------------
return {
    "nvim-neorg/neorg",
    -- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    dependencies = {'hrsh7th/nvim-cmp'},
    version = "*", -- Pin Neorg to the latest stable release
    ft = "norg", -- lazy-load on filetype
    config = function()
        local neorg = require("neorg")

        neorg.setup({
            --
            -- Here is the supported module list
            --
            -- https://github.com/nvim-neorg/neorg/wiki#default-modules
            --
            load = {
                --
                -- Neorg comes with some default modules that will be automatically
                -- loaded if you require the core.defaults module:
                --
                -- core.clipboard.code-blocks - Removes beginning whitespace from text copied from code blocks.
                -- core.esupports.hop - "Hop" between Neorg links, following them with a single keypress.
                -- core.esupports.indent - A set of instructions for Neovim to indent Neorg documents.
                -- core.esupports.metagen - A Neorg module for generating document metadata automatically.
                -- core.itero - Module designed to continue lists, headings and other iterables.
                -- core.journal - Easily track a journal within Neorg.
                -- core.keybinds - Module for managing keybindings with Neorg mode support.
                -- core.looking-glass - Allows for editing of code blocks within a separate buffer.
                -- core.pivot - Toggles the type of list currently under the cursor.
                -- core.promo - Promotes or demotes nestable items within Neorg files.
                -- core.qol.toc - Generates a table of contents for a given Norg buffer.
                -- core.qol.todo_items - Module for implementing todo lists.
                -- core.tangle - An Advanced Code Block Exporter.
                -- core.ui.calendar - Opens an interactive calendar for date-related tasks.
                --
                -- But you're able to disable some of theme like below:)
                --
                ["core.defaults"] = {
                    -- config = {
                    --     disable = {
                    --         -- module list goes here
                    --         "core.autocommands",
                    --         "core.itero",
                    --     },
                    -- },
                },

                -----------------------------------------------------------------
                -- Modules below will be loaded as custom configuration (override
                -- the default settings loaded by `core.defaults`)
                -----------------------------------------------------------------

                --
                -- Enable the imporved or custom look&feel
                --
                -- https://github.com/nvim-neorg/neorg/wiki/Concealer
                --
                ["core.concealer"] = {
                    config = {
                        --
                        -- Open all folding headings/sections or not when opening
                        -- norg file: `always`, `auto`, `never`
                        --
                        init_open_folds = "auto",

                        icon_preset = "basic",      -- { "◉", "◎", "○", "✺", "▶", "⤷" },
                        -- icon_preset = "diamond", -- { "◈", "◇", "◆", "⋄", "❖", "⟡" },
                        -- icon_preset = "varied",  -- { "◉", "◆", "✿", "○", "▶", "⤷" },


                        icons = {
                            heading = {
                                icons = { "➊", "➋", "➌", "➍", "➎", "➏" },
                            },

                            code_block = {
                                -- If true will only dim the content of the code block (without the
                                -- `@code` and `@end` lines), not the entirety of the code block itself.
                                content_only = false,

                                -- The width to use for code block backgrounds.
                                --
                                -- When set to `fullwidth` (the default), will create a background
                                -- that spans the width of the buffer.
                                --
                                -- When set to `content`, will only span as far as the longest line
                                -- within the code block.
                                width = "content",

                                -- When set to a number, the code block background will be at least
                                -- this many chars wide. Useful in conjunction with `width = "content"`
                                min_width = 78,

                                -- Additional padding to apply to either the left or the right. Making
                                -- these values negative is considered undefined behaviour (it is
                                -- likely to work, but it's not officially supported).
                                padding = {
                                    left = 4,
                                    right = 0,
                                },

                                -- If `true` will conceal (hide) the `@code` and `@end` portion of the code
                                -- block.
                                conceal = false,

                                -- If `false` will disable spell check on code blocks when 'spell' option is switched on.
                                spell_check = true,

                                -- nodes = { "ranged_verbatim_tag" },
                                -- highlight = "@neorg.tags.ranged_verbatim.code_block",
                                -- render = module.public.icon_renderers.render_code_block,
                                insert_enabled = true,
                            },

                            footnote = {
                                single = {
                                    icon = "",
                                },
                                multi_prefix = {
                                    icon = " ",
                                },
                                multi_suffix = {
                                    icon = " ",
                                },
                            },
                        },
                    },
                },

                --
                -- https://github.com/nvim-neorg/neorg/wiki/Indent
                --
                ["core.esupports.indent"] = {
                    config = {
                        indents = {
                            heading1 = { indent = 0 },
                            heading2 = { indent = 2 },
                            heading3 = { indent = 4 },
                            heading4 = { indent = 8 },
                            heading5 = { indent = 12 },
                            heading6 = { indent = 14 },
                        },
                    },
                },

                -- --
                -- -- Default keybings:
                --
                -- -- https://github.com/nvim-neorg/neorg/wiki/User-Keybinds
                --
                -- ["core.keybinds"] = {
                --     config = {
                --         default_keybinds = false,
                --     },
                -- },

                --
                -- It allows you to edit code block in a sparated buffer with
                -- LSP support.
                --
                -- https://github.com/nvim-neorg/neorg/wiki/Looking-Glass
                --
                ["core.looking-glass"] = {
                },


                -----------------------------------------------------------------
                -- Load all non-deault modules from here
                -----------------------------------------------------------------

                --
                -- https://github.com/nvim-neorg/neorg/wiki/Completion
                --
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                    },
                },

            }
        })

        -- print("neorg: "..vim.inspect(neorg.modules.loaded_modules["core.completion"]))
        -- print("neorg: "..vim.inspect(neorg.modules.loaded_modules["core.esupports.hop"]))

        --
        -- Add local buffer keybindings when openning `norg` file
        --
        vim.api.nvim_create_autocmd({"BufReadPost"}, {
            pattern = {"*.norg"},

            --
            -- group (string|integer) optional: autocommand group name or id to
            -- match against.
            --
            group = vim.api.nvim_create_augroup('NeorgAutoCmdConfig', {}),

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

                --
                -- Fixed the link look&feel: Concealed text is completely hidden.
                --
                vim.wo.conceallevel = 3

                -- print(">>> Neorg BufReadPost callback, event: "..vim.inspect(event))
                local keybinding_opts = {
                    -- Only bind to the attached buffer (local binding)
                    buffer = event.buf,
                    silent = true,
                    desc = "",
                }

                ---------------------------------------------------------------
                -- Set LSP keybindings
                ---------------------------------------------------------------
                keybinding_opts.desc = "Neorg: Go go next fold"
                vim.keymap.set('n',
                    '<C-J>',
                    'zj',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Go go prev fold"
                vim.keymap.set('n',
                    '<C-K>',
                    'zk',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Toggle current fold"
                vim.keymap.set('n',
                    '<CR>',
                    'za',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Open menu (Table Of Content)"
                vim.keymap.set('n',
                    '<leader>om',
                    '<cmd>Neorg toc<CR>',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Task status"
                vim.keymap.set('n',
                    '<leader>ts',
                    '<Plug>(neorg.qol.todo-items.todo.task-cycle)',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: List toggle"
                vim.keymap.set('n',
                    '<leader>lt',
                    '<Plug>(neorg.pivot.list.toggle)',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Code (block) edit"
                vim.keymap.set('n',
                    '<leader>ce',
                    '<Plug>(neorg.looking-glass.magnify-code-block)',
                    keybinding_opts)

                keybinding_opts.desc = "Neorg: Open link"
                vim.keymap.set('n',
                    '<leader>ol',
                    -- '<Plug>(neorg.esupports.hop.hop-link)',
                    '<Plug>(neorg.esupports.hop.hop-link.vsplit)',
                    keybinding_opts)

                --
                -- -- Insert a link to a date at the given position
                -- -- ^Insert Date
                -- { "<LocalLeader>id", "<Plug>(neorg.tempus.insert-date)", opts = { desc = "[neorg] Insert Date" } },
            end
        })

    end
}
