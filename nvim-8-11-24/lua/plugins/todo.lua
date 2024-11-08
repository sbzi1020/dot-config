--
-- Support todo comment type:
--     --TODO
--     --HACK
--     --BUG
--     --NOTE
--     --FIX
--     --WARN/WARNING
--     --TEST
-- 
return {
    'folke/todo-comments.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require('todo-comments')
        todo_comments.setup()

        vim.keymap.set('n',
            '<leader>pt',
            '<cmd>TodoTelescope<CR>',
            {
                silent = true,
                desc = "Project todo list",
            })
    end
}
