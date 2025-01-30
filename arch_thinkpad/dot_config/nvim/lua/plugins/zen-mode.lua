return {
    "folke/zen-mode.nvim",
    config = function()
        require('zen-mode').setup({
            window = {
                --
                -- Shade the backdrop of the Zen window. Set to 1 to keep the
                -- same as Normal
                --
                backdrop = 0.95,

                --
                -- Height and width can be:
                -- * an absolute number of cells when > 1
                -- * a percentage of the width / height of the editor when <= 1
                -- * a function that returns the width or the height
                --
                width = 0.6,
                height = 0.95,

                --
                -- By default, no options are changed for the Zen window
                -- uncomment any of the options below, or add other vim.wo
                -- options you want to apply
                --
                options = {
                    -- signcolumn = "no", -- disable signcolumn
                    -- number = false, -- disable number column
                    -- relativenumber = false, -- disable relative numbers
                    -- cursorline = false, -- disable cursorline
                    -- cursorcolumn = false, -- disable cursor column
                    -- foldcolumn = "0", -- disable fold column
                    -- list = false, -- disable whitespace characters
                },
            },
            plugins = {
                --
                -- Disables the "tmux" status, but it causes the screen to
                -- refresh, it doesn't feel good:)
                --
                -- tmux = { enabled = true },

                --
                -- this will change the font size on alacritty when in zen mode
                -- requires  Alacritty Version 0.10.0 or higher
                -- uses `alacritty msg` subcommand to change font size
                --
                alacritty = {
                    enabled = true,
                    font = "17.0", -- font size
                },
            },
            -- --
            -- -- callback where you can add custom code when the Zen window opens
            -- --
            -- on_open = function(win)
            --     print(">> Zen mode is on.")
            -- end,

            -- --
            -- -- callback where you can add custom code when the Zen window closes
            -- --
            -- on_close = function()
            --     print(">> Zen mode is off.")
            -- end,
        })

        vim.keymap.set('n',
            '<leader><CR>',
            '<cmd>ZenMode<CR>',
            {
                silent = true,
                desc = "Toggle zen mode",
            }
        )
    end;
}
