vim.g.enable_vim_debug = false

if vim.g.enable_vim_debug then print "'init.lua' has been reloaded >>>" end

--[[
This function to reload all packages in this file, then we can
use this function to replace the `require` which can FORCE te
reload a package which more easy to reload `init.lua`.

There is a keybinding defined in `keybindings` package to reload
this file by pressing `<leader>rr`.
--]]
function Reload_package(package_name, args)
    package.loaded[package_name] = nil

    -- `pcall`(protected call) gives us a way to skip the package if it loads
    -- fail and it won't affect the rest loading process.
    local status_ok, loaded_package = pcall(require, package_name, args)

    if args then
        print("args: "..vim.inspect(args))
        print(status_ok)
        print(vim.inspect(loaded_package))
    end

    if not status_ok then
        -- print(">>> Fail to load package: `" .. package_name .. "`")
        -- print(">>> Extra error: " .. vim.inspect(loaded_package) .. "\n")
        return
    end

    return loaded_package
end


-- Settings module, include all basic vim option settings.
Reload_package('my_settings')


-- Plugins modules (not include LSP)
Reload_package 'my_plugins'
Reload_package 'my_statusline'
--Reload_package 'my_nvim_tree'
Reload_package 'my_tmuxline'
Reload_package 'my_indent_blankline'
Reload_package 'my_goyo'
Reload_package 'my_firenvim'
Reload_package 'my_markdown_preview'

-- Make sure `my_treesitter` loads BEFORE `my_telescope`.
-- Otherise, treesitter highlight will stop working!!!
Reload_package 'my_treesitter'
Reload_package 'my_telescope'
Reload_package 'my_colorizer'
Reload_package 'my_nvim_comment'


-- LSP(Language Server Protocol) modules
Reload_package 'lsp/my_lsp'
-- Reload_package 'lsp/coc'


-- Themes modules
Reload_package 'my_themes'


--[[
keybindings module

This module includes all plugin's keybinding, centralized configuration,
easy manipulation.

And this module HAS TO be required/loaded AFTER all plugins has been loaded,
that can make sure the settings will override the default keybindings.
--]]
Reload_package 'my_keybindings'

-- Load pre-defined macros
Reload_package 'my_macros'

-- Load auto groups
Reload_package 'my_auto_groups'


--[[
This is the simple way to control override highlight groups whether using
custom color theme plugins or not.
--]]
--vim.cmd 'hi Cursor1 guifg=#23211B guibg=green'
--vim.cmd 'hi Cursor2 guifg=#F44747 guibg=#67615d'
vim.cmd 'hi CursorLine guifg=NONE guibg=#493d35'
--vim.cmd 'hi Visual guifg=NONE guibg=#ced3ac'


--[[
Test rust plugin
--]]
--Reload_package 'vim_plugin_demo'.setup({
--    enable_debug_log = true
--})
