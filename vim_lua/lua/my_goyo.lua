if vim.g.enable_vim_debug then print "'my_goyo' has been reloaded >>>" end

--[[
-----------------------------------------------------------------------
goyo
-----------------------------------------------------------------------
--]]
-- Make the popup window width a little bit
vim.cmd 'let g:goyo_width=\'80%\''

-- Enable the relative number when going into `GOYO` mode!
function Goyo_enter()
    -- Enable hybird number (Absoluate and relative number)
    vim.wo.number = true
    vim.wo.relativenumber = true
end

function Goyo_leave()
end

vim.cmd([[
    autocmd! User GoyoEnter :call luaeval('Goyo_enter()')
    autocmd! User GoyoLeave :call luaeval('Goyo_leave()')
]])
