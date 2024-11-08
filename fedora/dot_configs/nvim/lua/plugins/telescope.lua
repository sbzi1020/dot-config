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


local callback = function()
    local telescope = Reload_package('telescope')
    local actions = Reload_package('telescope.actions')
    local builtin = require('telescope.builtin')
    local lga_actions = require("telescope-live-grep-args.actions")

    local setup_opts = {
        defaults = {
            -- popup window opacity: 0 ~ 100 (fully transparent)
            winblend = 10,

            layout_config = {
                -- Popup window settings
                width = 0.90,

                -- Prompt (Search bar) position
                prompt_position = "top",
            },

            -- Result list sorting
            sorting_strategy = "ascending", -- `descending/ascending`

            -- Previews
            file_previewer = require 'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require 'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require 'telescope.previewers'.vim_buffer_qflist.new,

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

                    -- ["<c-f>"] = actions.to_fuzzy_refine ,
                },

                -- `normal` mode:
                n = {
                    -- Open selection by `vsplit`
                    -- ["<CR>"] = actions.select_vertical,
                    ["<CR>"] = actions.select_default,
                },
            },
        },
        -- Picker options
        pickers = {
            find_files = {
                prompt_title = "Find files in project",
                prompt_prefix = "  ",
            },
            live_grep = {
                prompt_title = "Fuzzy text search in project",
                prompt_prefix = "  ",
                shorten_path = true,
            },
            help_tags = {
                prompt_title = "Search from help",
                prompt_prefix = "  ",
            },
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
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },

            --[[
            cmdline
            --]]
            cmdline = {
                picker   = {
                    layout_config = {
                        width  = 100,
                        height = 30,
                    }
                },
                mappings = {
                    complete      = '<Tab>',
                    run_selection = '<C-e>',
                    run_input     = '<CR>',
                },
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
            live_grep_args = {
                -- enable/disable auto-quoting
                auto_quoting = false,

                mappings = {
                    i = {
                        --
                        -- Freeze the current entry list (matched result) and
                        -- start a fuzzy search in the frozen entry list
                        --
                        ["<C-f>"] = actions.to_fuzzy_refine,
                    },
                },

                --
                -- ... also accepts theme settings, for example:
                --
                -- theme = "dropdown", -- use dropdown theme
                -- theme = { }, -- use own theme spec

                layout_config = {
                    width  = 0.95,
                    -- height = 0.8,
                }
            },
        }
    }

    telescope.setup(setup_opts)

    --
    -- Load extensions
    --
    -- telescope.load_extension('fzf')
    telescope.load_extension('cmdline')
    telescope.load_extension('live_grep_args')
    -- telescope.load_extension('repo')

    --
    -- Keybindings
    --
    vim.keymap.set('n',
        ':',
        ':Telescope cmdline<CR>',
        {
            noremap = true,
            desc = "Command mode line",
        }
    )

    vim.keymap.set('n',
        '<leader>pf',
        builtin.find_files,
        {
            silent = true,
            desc = "Project find files",
        }
    )

    local function find_files_in_home()
        builtin.find_files({
            cwd = "~",
            prompt_title = "Find files in home directory",
        })
    end

    vim.keymap.set('n',
        '<leader>hf',
        find_files_in_home,
        {
            silent = true,
            desc = "Home find files",
        }
    )

    vim.keymap.set('n',
        '<leader>b',
        builtin.buffers,
        {
            silent = true,
            desc = "Find in buffers",
        }
    )

    vim.keymap.set('n',
        '<leader>h',
        builtin.help_tags,
        {
            silent = true,
            desc = "Find in helps",
        }
    )

    vim.keymap.set('n',
        '<leader>pr',
        builtin.live_grep,
        {
            silent = true,
            desc = "Project fuzzy search",
        })

    vim.keymap.set('n',
        '<leader>ch',
        builtin.command_history,
        {
            silent = true,
            desc = "Find in command history",
        })

    vim.keymap.set('n',
        'z=',
        builtin.spell_suggest,
        {
            silent = true,
            desc = "Spell sugestion",
        })

    vim.keymap.set('n',
        '<leader>pc',
        '<cmd>lua require("my_project_command").run()<CR>',
        {
            silent = true,
            desc = "Project command"
        })

    vim.keymap.set('n',
        '<leader>rg',
        ':Telescope live_grep_args<CR>',
        {
            silent = true,
            desc = "Project fuzzy search",
        })

end


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
        --
        -- Telescope extension to use command line in a floating window,
        -- rather than in bottom-left corner.
        --
        'jonarrien/telescope-cmdline.nvim',
        --
        -- Telesope extension to allow you to put `rg` args into the prompt!!!
        --
        -- By defuat, the `~/` won't be expanded to your home folder, you have
        -- to add this:
        --
        -- `current_arg = string.gsub(current_arg, "~/", vim.fn.expand("~/"))`
        --
        -- to the line:150 of the following file:
        --
        -- ~/.local/share/nvim/lazy/telescope-live-grep-args.nvim/lua/telescope-live-grep-args/prompt_parser.lua
        --
        -- before the line `table.insert(parts, current_arg)`!!!
        -- 
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            -- This will not install any breaking changes.
            -- For major updates, this must be adjusted manually.
            version = "^1.0.0",
        }
    },
    config = callback,
}
