return {
    "Tsuzat/NeoSolarized.nvim",
    enabled = true,
    lazy = false,

    --[[ Only useful for start plugins `lazy=false` to force loading certain
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
        require("NeoSolarized").setup({
            style = "light", -- "dark" or "light"
            transparent = false, -- true/false; Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            enable_italics = true, -- Italics for different hightlight groups (eg. Statement, Condition, Comment, Include, etc.)
            styles = {
                -- Style to be applied to different syntax groups
                comments = { italic = true },
                keywords = { italic = true },
                functions = { bold = true },
                variables = {},
                string = { italic = true },
                underline = true, -- true/false; for global underline
                undercurl = true, -- true/false; for global undercurl
            },
            -- -- Add specific hightlight groups
            -- on_highlights = function(highlights, colors) 
            --     -- highlights.Include.fg = colors.red -- Using `red` foreground for Includes
            -- end, 
        })

        -- Load colorscheme
        --
        vim.cmd("colorscheme NeoSolarized")
    end
}
