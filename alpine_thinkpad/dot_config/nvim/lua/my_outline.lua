local loaded_package = Reload_package( "outline")

loaded_package.setup({
    show_cursorline = true,
    hide_cursor = true,
    center_on_jump = true,
})

--
-- Toggle outline, keep that in mind `<leader>` doesn't set to `<Sapce>` yet
-- before loading `my_keybingings.lua`!!!
-- 
vim.keymap.set('n', '<Space>im', ':Outline<CR>')
