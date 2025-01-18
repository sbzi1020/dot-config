return {
    'luisiacc/gruvbox-baby',
    enabled = false,
    lazy = false,

    --[[
    Only useful for start plugins `lazy=false` to force loading certain
    plugins first. Default priority is 50. It's recommended to set this to
    a high number for colorschemes.
    --]]
    priority = 1000,

    --[[
    `config` is executed when the plugin loads.

    When set to `true`, the default implementation will automatically run:

    `require(MODULE).setup()`
    --]]
    config = function()
        -- Customize configuration
        -- vim.cmd('let g:gruvbox_baby_function_style = "NONE"')
        -- vim.cmd('let g:gruvbox_baby_keyword_style = "italic"')

        --
        -- DO NOT enable this, it mess the picker top prompt!!!
        --
        -- vim.cmd('let g:gruvbox_baby_telescope_theme = 1')

        -- Enable transparent mode
        -- vim.cmd('let g:gruvbox_baby_transparent_mode = 1')

        -- Load colorscheme
        vim.cmd("colorscheme gruvbox-baby")
        -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    end
}
