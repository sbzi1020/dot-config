--[[
-----------------------------------------------------------------------
Disable spell checking for all file types by default. But you can toggle
the spell checking by press `<leader>sc` at any given time.
-----------------------------------------------------------------------
--]]
-- vim.cmd 'autocmd FileType javascript,typescript,rust,typescriptreact,go,lua,tmux,yaml,vim,fish,toml,json,cmake,markdown,css,conf,sh,man setlocal nospell'
vim.api.nvim_create_autocmd('FileType', {
    pattern = '*',
    --pattern = { 'javascript','typescript','rust','typescriptreact','go','lua','tmux','yaml','vim','fish','toml','json','cmake','markdown','css','conf','sh','man' },

    --[[
    When you want to execute vim settings and run extra function, use `callback`

    When you only want to execute `lua/vim` command, use `command`
    --]]
    callback = function()
        -- Disable spelling
        vim.wo.spell = false

        -- print out the debug message
        -- local debugMsg = {
        --     fileName = vim.fn.expand('<afile>'),
        --     matchFileType = vim.fn.expand('<amatch>')
        -- }

        -- vim.schedule(function()
        --     print("Already disabled spelling.")
        --     print("Auto command debug message: "..vim.inspect(debugMsg))
        -- end)
    end,
})


--[[
-----------------------------------------------------------------------
Disable spell checking for opening terminal
-----------------------------------------------------------------------
--]]
--vim.cmd 'autocmd TermOpen * setlocal nospell'
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.spell = false
    end,
})



--[[
-----------------------------------------------------------------------
Enable highlight when yanked, `TextYankPost` event auto command
-----------------------------------------------------------------------
--]]
--vim.cmd [[
--    augroup highlight_yank
--        autocmd!
--        au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
--    augroup END
--]]
vim.api.nvim_create_autocmd('TextYankPost ', {
    command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }",
    group = vim.api.nvim_create_augroup('YankGroup', { clear = true })
})
