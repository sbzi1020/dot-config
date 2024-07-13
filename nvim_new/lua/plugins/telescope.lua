--[[
-----------------------------------------------------------------------
Telescope

1. `telescope.actions` allows you to call some useful functions for the
customized keybindings when the popup window shows up. You can know
all function names from here:

https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua

2. Here is the default keybindings:

https://github.com/nvim-telescope/telescope.nvim/blob/bfcc7d5c6f12209139f175e6123a7b7de6d9c18a/lua/telescope/mappings.lua

2. `:Telescope builtin` command can list all supported function name:)
-----------------------------------------------------------------------
--]]
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
        },
        'jonarrien/telescope-cmdline.nvim',
    },
    config = function()
        local actions = Reload_package('telescope.actions')

        require('telescope').setup({
            defaults = {
                -- Grep settings
                vimgrep_arguments = {
                    'rg',
                    '--color=never',
                    '--no-heading',
                    '--with-filename',
                    '--line-number',
                    '--column',
                    '--smart-case'
                },

                layout_config = {
                    -- Popup window settings
                    width = 0.90,

                    -- Prompt (Search bar) position
                    prompt_position = "top",

                    -- layout_strategy = "flex",
                    horizontal = {
                        -- The width of preview window
                        preview_width = 0.45,

                        -- If set to `true`, then swap `result list` and `preview window`
                        mirror = false,
                    }
                },

                layout_strategy = "horizontal",

                -- Prompt (Search bar) settings
                prompt_prefix = "> ",
                selection_caret = "> ",
                entry_prefix = "  ",
                initial_mode = "insert", -- Need to `<ESC>` before you can move up and down in result list

                -- Result list sorting
                sorting_strategy = "ascending", -- `descending/ascending`

                -- Previews
                file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
                grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
                qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

                -- Customized key mapping
                mappings = {
                    -- `insert` mode: Send the result list content to `quickfix list`
                    -- i = {
                        --     ["<C-x>"] = false,
                        --     ["<C-q>"] = actions.send_to_qflist,
                        -- },

                        -- `insert` mode: 
                        i = {
                            -- Use <c-j> and <c-k> to move up and down
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous,

                            -- Open selection by `vsplit`
                            ["<C-v>"] = actions.select_vertical,
                            ["<CR>"] = actions.select_default,
                        },
                        -- `normal` mode:
                        n = {
                            -- Open selection by `vsplit`
                            -- ["<CR>"] = actions.select_vertical,
                            ["<CR>"] = actions.select_default,
                        },
                    }
                },
                extensions = {
                    --[[

                    | Token     | Match type                    | Description
                    ----------------------------------------------------------------------
                    | sbtrkt    | fuzzy-match                   | Items that match `sbtrkt`
                    | 'wild     | exact-match (quoted)          | Items that include `wild`
                    | ^music    | prefix-exact-match            | Items that start with `music`
                    | .mp3$     | suffix-exact-match            | Items that end with `.mp3`
                    | !fire     | inverse-exact-match           | Items that do not include `fire`
                    | !^music   | inverse-prefix-exact-match    | Items that do not start with `music`
                    | !.mp3$    | inverse-suffix-exact-match    | Items that do not end with `.mp3`

                    A single bar character term acts as an OR operator. For example, the following query matches entries that start with core and end with either go, rb, or py.

                    `^core go$ | rb$ | py$`

                    --]]
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    },

                    --[[
                    cmdline
                    --]]
                    cmdline = {
                        picker = {
                            layout_config = {
                                width  = 100,
                                height = 30,
                            }
                        },
                        -- mappings    = {
                            --     complete      = '<Tab>',
                            --     run_selection = '<C-CR>',
                            --     run_input     = '<CR>',
                            -- },
                            overseer = {
                                enabled = false,
                            },
                        },
                        repo = {
                            list = {
                                fd_opts = {
                                    "--no-ignore-vcs",
                                },
                                search_dirs = {
                                    "~/c",
                                    "~/hare",
                                    "~/rust",
                                    "~/zig",
                                },
                            },
                        },
                    }
                })

                -- Load extensions
                require('telescope').load_extension('fzf')
                require('telescope').load_extension('cmdline')
                -- require('telescope').load_extension('repo')

                vim.keymap.set('n',
                    ':',
                    ':Telescope cmdline<CR>',
                    {
                        noremap = true,
                        desc = "Command mode line",
                    })

                vim.keymap.set('n',
                    '<leader>pf',
                    ':lua require(\'telescope.builtin\').find_files({layout_strategy = \'vertical\', layout_config = {width=0.6}, previewer = false })<CR>',
                    {
                        silent=true,
                        desc = "Project find files",
                    })

                vim.keymap.set('n',
                    '<leader>b',
                    ':lua require(\'telescope.builtin\').buffers()<CR>',
                    {
                        silent=true,
                        desc = "Find in buffers",
                    })

                vim.keymap.set('n',
                    '<leader>h',
                    ':lua require(\'telescope.builtin\').help_tags()<CR>',
                    {
                        silent = true,
                        desc = "Find in helps",
                    })

                vim.keymap.set('n',
                    '<leader>pr',
                    ':lua require(\'telescope.builtin\').live_grep({prompt_title="Search in project", prompt_prefix="  ", shorten_path=true})<CR>',
                    {
                        silent = true,
                        desc = "Project fuzzy search",
                    })

                vim.keymap.set('n',
                    '<leader>ch',
                    ':lua require(\'telescope.builtin\').command_history()<CR>',
                    {
                        silent = true,
                        desc = "Find in command history",
                    })


                vim.keymap.set('n',
                    'z=',
                    '<cmd>lua require(\'telescope.builtin\').spell_suggest()<CR>',
                    {
                        silent = true,
                        desc = "Spell sugestion",
                    })

                -- vim.keymap.set('n',
                --     '<leader>ps',
                --     ':Telescope repo list<CR>',
                --     {
                --         slient = true,
                --         desc = "Project (repo) Switch"
                --     })

            end
        }
