if vim.g.enable_vim_debug then print "'my_themes' has been loaded >>>" end

--[[
After changing `current_theme`, you need to press `<leader>rr` to reload to
take effect.

For customized colorschemes:
They don't need to be installed, as they located in `~/.config/nvim/colors`
which is the default folder of `runtimepath`.  The first one of the
`$VIMRUNTIME/colors/{name}.(vim|lua)` is found is loaded.

After colorscheme has been load, you can run `:echo g:colors_name` command
to show it.
]]
--local current_theme = "classic_old_green"
--local current_theme = "pinkgirl"
--local current_theme = "tron"
--local current_theme = "tron-white"
--local current_theme = "cute_duck"
--local current_theme = "golden"
--local current_theme = "onedark"
--local current_theme = "1989"
--local current_theme = "gruvbox"
local current_theme = "gruvbox-baby"

if vim.g.enable_vim_debug then print("current_theme: ", current_theme) end


--[[
Apply different settings for the particular colorscheme
--]]
if current_theme == "onedark" then

    --vim.g.onedark_style = 'dark'
    vim.g.onedark_style = 'cool'
    vim.g.onedark_italic_comment = true
    vim.g.onedark_transparent_background = true
    vim.g.onedark_disable_terminal_colors = false
    vim.g.onedark_diagnostics_undercurl = true
    vim.g.onedark_darker_diagnostics = true
    vim.g.onedark_hide_ending_tildes = false

elseif current_theme == "gruvbox" then
    -- setup must be called before loading the colorscheme
    -- Default options:
    require("gruvbox").setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = true,
            operators = true,
            comments = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "", -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = true,
    })

    -- -- Use `Dark` mode
    -- vim.cmd 'set background=dark'

    -- vim.g.gruvbox_color_column="bright_yellow"

    -- -- The vertical separated line's color
    -- vim.g.gruvbox_vert_split="bright_red"

    -- -- This make the selection looks better
    -- vim.g.gruvbox_invert_selection=0

    -- -- Show the cursor line with the following color setting
    -- vim.cmd 'set cursorline'
    -- vim.cmd 'hi CursorLineNr term=bold ctermfg=0 ctermbg=214 guifg=#fabd2f guibg=#3c3836'
    --
elseif current_theme == "gruvbox-baby" then
    -- Each highlight group must follow the structure:
    -- ColorGroup = {fg = "foreground color", bg = "background_color", style = "some_style(:h attr-list)"}
    -- See also :h highlight-guifg
    -- Example:
    -- vim.g.gruvbox_baby_highlights = {Normal = {fg = "#123123", bg = "NONE", style="underline"}}

    -- Enable telescope theme
    --vim.g.gruvbox_baby_telescope_theme = 1

    -- Enable transparent mode
    vim.g.gruvbox_baby_transparent_mode = 1

elseif current_theme == "base-16" then

    vim.cmd 'let base16colorspace=256'

elseif current_theme == "monokai" then

    --vim.g.molokai_original = 1
    --vim.g.rehash256 = 1

elseif current_theme == "tron" then

    vim.cmd 'let g:nvcode_termcolors=256'

elseif current_theme == "tron-white" then

    vim.cmd 'let g:nvcode_termcolors=256'

elseif current_theme == "classic_old_green" then

    vim.cmd 'let g:nvcode_termcolors=256'

elseif current_theme == "pinkgirl" then

    vim.cmd 'let g:nvcode_termcolors=256'

elseif current_theme == "1989" then

    vim.cmd 'let g:nvcode_termcolors=256'

end

--
-- Load the `current_theme` colorscheme in a safety way:
--
local status_ok, loaded_colorscheme = pcall(vim.cmd, "colorscheme " .. current_theme)
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

if not status_ok then
    print("Fail to load colorscheme: " .. current_theme)
    return
end
