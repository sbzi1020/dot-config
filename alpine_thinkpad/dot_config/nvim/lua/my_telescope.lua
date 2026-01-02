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
    extensions = {
        -- bookmarks = {
        --     -- Available:
        --     --  * 'brave'
        --     --  * 'buku'
        --     --  * 'chrome'
        --     --  * 'chrome_beta'
        --     --  * 'edge'
        --     --  * 'firefox'
        --     --  * 'qutebrowser'
        --     --  * 'safari'
        --     --  * 'vivaldi'
        --     --  * 'waterfox'
        --     selected_browser = 'chrome',

        --     -- Either provide a shell command to open the URL
        --     url_open_command = 'open',

        --     -- Or provide the plugin name which is already installed
        --     -- Available: 'vim_external', 'open_browser'
        --     url_open_plugin = nil,

        --     -- Show the full path to the bookmark instead of just the bookmark name
        --     full_path = true,

        --     -- Provide a custom profile name for Firefox browser
        --     firefox_profile_name = nil,

        --     -- Provide a custom profile name for Waterfox browser
        --     waterfox_profile_name = nil,

        --     -- Add a column which contains the tags for each bookmark for buku
        --     buku_include_tags = false,

        --     -- Provide debug messages, use this flag to confirm this plugin loaded
        --     -- correctly or not!!!
        --     debug = false,
        -- },
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
        -- fzf = {
        --     fuzzy = true,                    -- false will only do exact matching
        --     override_generic_sorter = true,  -- override the generic sorter
        --     override_file_sorter = true,     -- override the file sorter
        --     case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        --                                      -- the default case_mode is "smart_case"
        -- },
    }
})

-- Load extensions
-- require('telescope').load_extension('bookmarks')
-- require('telescope').load_extension('fzf')
