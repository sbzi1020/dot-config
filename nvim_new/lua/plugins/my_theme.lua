return {
    'luisiacc/gruvbox-baby',

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

        -- Enable telescope theme
        vim.cmd('let g:gruvbox_baby_telescope_theme = 1')

        -- Enable transparent mode
        vim.cmd('let g:gruvbox_baby_transparent_mode = 1')

        -- Load colorscheme
        local current_theme = "gruvbox-baby"
        local status_ok, loaded_colorscheme = pcall(
            vim.cmd,
            "colorscheme " .. current_theme
        )

        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

        if not status_ok then
            print("Fail to load colorscheme: " .. current_theme)
            return
        end
    end
}