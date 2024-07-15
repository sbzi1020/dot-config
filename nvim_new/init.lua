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
        print(">>> Fail to load package: `" .. package_name .. "`")
        print(">>> Extra error: " .. vim.inspect(loaded_package) .. "\n")
        return
    end

    return loaded_package
end


Reload_package('my_settings')
Reload_package('my_keybindings')
Reload_package('my_plugins')
Reload_package('my_auto_groups')
-- Reload_package 'my_goyo'
-- Reload_package 'my_firenvim'
-- 
-- -- Reload_package 'my_colorizer'
-- Reload_package 'my_nvim_comment'
-- 
-- 
-- -- -- Themes modules
-- Reload_package 'my_themes'
-- 
-- -- -- Vim be good
-- -- Reload_package 'my_vim_be_good'
-- 
-- 
-- 
-- -- Outline support
-- Reload_package 'my_outline'
-- 
-- -- Floaterm
-- Reload_package 'my_floatterm'
-- 
-- -- Load pre-defined macros
-- Reload_package 'my_macros'
-- 
-- -- Load auto groups
-- 
-- -- Load hare setup
-- Reload_package 'my_hare_setup'



-- --[[
-- This is the simple way to control override highlight groups whether using
-- custom color theme plugins or not.
-- --]]
-- vim.cmd 'hi CursorLine guifg=NONE guibg=#493d35'

