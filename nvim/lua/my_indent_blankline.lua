if vim.g.enable_vim_debug then print "'my_indent_blankline' has been loaded >>>" end

Reload_package("ibl").setup({
    scope = { enabled = false },
})
