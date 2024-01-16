if vim.g.enable_vim_debug then print "'my_colorizer' has been reloaded >>>" end

local loaded_package = Reload_package('colorizer')
loaded_package.setup({
    'css',
    'javascript',
    'typescript',
    'tsx',
    'typescriptreact',
    'html',
    'vim',
})
