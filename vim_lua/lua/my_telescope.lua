if vim.g.enable_vim_debug then print "'my_telescope' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
Telescope

1. `telescope.actions` allows you to call some useful functions for the
    customized keybindings when the popup window shows up. You can know
    all function names from here:

    https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/actions/init.lua

2. `:Telescope builtin` command can list all supported function name:)

-----------------------------------------------------------------------
--]]
local actions = Reload_package('telescope.actions')

Reload_package('telescope').setup({
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

            -- `insert` mode: Use <c-j> and <c-k> to move up and down
            i = {
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous
            },
        }
    },
})
