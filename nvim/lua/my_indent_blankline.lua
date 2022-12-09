if vim.g.enable_vim_debug then print "'my_indent_blankline' has been loaded >>>" end

--[[
Pay attention:

Only one option can be enabled at any given time!!!
Only one option can be enabled at any given time!!!
Only one option can be enabled at any given time!!!
--]]


--[[
[ Option A ]

Show current context indent block by treesitter
--]]
Reload_package("indent_blankline").setup({
    space_char_blankline = " ",
})


--[[
[ Option B ]

Show current context indent block by treesitter
--]]
-- Reload_package("indent_blankline").setup({
--     space_char_blankline = " ",
--     show_current_context = true,
--     show_current_context_start = true,
-- })


--[[
[ Option C ]

Rainbow color liked indent block
--]]
-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

-- vim.opt.list = true
-- vim.opt.listchars:append("space:⋅")
-- vim.opt.listchars:append("eol:↴")

-- Reload_package("indent_blankline").setup({
--     space_char_blankline = " ",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--         "IndentBlanklineIndent3",
--         "IndentBlanklineIndent4",
--         "IndentBlanklineIndent5",
--         "IndentBlanklineIndent6",
--     },
-- })
