-------------------------------------------------------------------------------
-- Disable spell checking for all file types by default. But you can toggle
-- the spell checking by press `<leader>sc` at any given time.
-----------------------------------------------------------------------
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
    end,
})


-------------------------------------------------------------------------------
-- Disable spell checking when opening terminal
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        vim.wo.spell = false
    end,
})



-----------------------------------------------------------------------
-- Enable highlight when yanked, `TextYankPost` event auto command
-----------------------------------------------------------------------
vim.api.nvim_create_autocmd({'TextYankPost'}, {
    command = "lua vim.highlight.on_yank { higroup='IncSearch', timeout=300 }",
    group = vim.api.nvim_create_augroup('YankGroup', { clear = true })
})
