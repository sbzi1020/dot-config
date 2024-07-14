if vim.g.enable_vim_debug then print "'my_plugins' has been loaded >>>" end

-------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        lazyrepo,
        lazypath
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Setup lazy.nvim
-------------------------------------------------------------------------------
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    install = {
        -- Install missing plugins on startup. This doesn't increase startup
        -- time.
        missing = true,

        -- Try to load one of these colorschemes when starting an installation
        -- during startup
        -- colorscheme = { "habamax" },
    },
    -- Automatically check for plugin updates
    checker = {
        enabled = true,
        notify = false, -- get a notification when new updates are found
    },
    -- automatically check for config file changes and reload the ui
    change_detection = {
        enabled = true,
        notify = false,
    },
})
