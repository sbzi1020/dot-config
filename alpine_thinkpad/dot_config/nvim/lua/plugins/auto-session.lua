return {
    'rmagatti/auto-session',
    dependencies = {
        'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },

    --
    -- Disabled, as I don't need it
    --
    enabled = false,

    config = function()
        require('auto-session').setup({
            auto_restore_enabled = false,
            auto_session_allowed_dirs = { '~/sbzi' },
            -- auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        })

        vim.keymap.set('n',
        '<leader>ws',
        '<cmd>SessionSave<CR>',
        {
            silent = true,
            desc = "Auto sessions: save",
        })

        vim.keymap.set('n',
        '<leader>wr',
        '<cmd>SessionRestore<CR>',
        {
            silent = true,
            desc = "Auto sessions: restore",
        })
    end,
}
