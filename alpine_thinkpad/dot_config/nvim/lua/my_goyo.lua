if vim.g.enable_vim_debug then print "'my_goyo' has been reloaded >>>" end

--[[
-----------------------------------------------------------------------
goyo
-----------------------------------------------------------------------
--]]
-- Make the popup window width a little bit
vim.cmd 'let g:goyo_width=\'60%\''
vim.cmd 'let g:goyo_height=\'90%\''

-- Enable the relative number when going into `GOYO` mode!
function Goyo_enter()
    -- Enable hybird number (Absoluate and relative number)
    vim.wo.number = true
    vim.wo.relativenumber = true

    print(">>> GoyoEnter trigged.")
end

function Goyo_leave()
    print(">>> GoyoLeave trigged.")
end

--vim.cmd([[
--    autocmd! User GoyoEnter :call luaeval('Goyo_enter()')
--    autocmd! User GoyoLeave :call luaeval('Goyo_leave()')
--]])

local GoyoGroup = vim.api.nvim_create_augroup('GoyoGroup', { clear = true })

vim.api.nvim_create_autocmd('User', {
    pattern = 'GoyoEnter',
    callback = Goyo_enter,
    group = GoyoGroup
})

vim.api.nvim_create_autocmd('User', {
    pattern = 'GoyoLeave',
    callback = Goyo_leave,
    group = GoyoGroup
})
