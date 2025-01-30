-- https://github.com/folke/which-key.nvim
return {
    'folke/which-key.nvim',
    event = "VeryLazy",

    ---------------------------------------------------------------------------
    -- `init` functions are always executed during startup. Mostly useful for
    -- setting vim.g.* configuration used by Vim plugins startup
    ---------------------------------------------------------------------------
    init = function()
        --[[
        'timeout': boolean (default on)
        global
        This option and 'timeoutlen' determine the behavior when part of a
        mapped key sequence has been received.

        For example, if `<c-f>` is pressed and 'timeout' is set, Nvim will
        wait 'timeoutlen' milliseconds for any key that can follow `<c-f>`
        in a mapping.

        'timeoutlen': number (default 1000)
        global
        Time in milliseconds to wait for a mapped sequence to complete.
        --]]
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end,
    opts = {
        win = {
            -- width = 1,
            -- height = { min = 4, max = 25 },
            -- col = 0,
            row = -1,
            -- border = "none",
            padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
            title = true,
            title_pos = "center",
            zindex = 1000,
            -- Additional vim.wo and vim.bo options
            bo = {},
            wo = {
                -- value between 0-100 0 for fully opaque and 100 for fully
                -- transparent
                winblend = 20,
            },
        },
        layout = {
            width = { min = 20 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "right", -- align columns left, center or right
        },
        -- triggers = true, -- automatically setup triggers
        -- disable = {
        --     -- disable WhichKey for certain buf types and file types.
        --     ft = {},
        --     bt = {},
        --     -- disable a trigger for a certain context by returning true
        --     ---@type fun(ctx: { keys: string, mode: string, plugin?: string }):boolean?
        --     trigger = function(ctx)
        --         return false
        --     end,
        -- },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
}
