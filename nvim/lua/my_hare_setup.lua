if vim.g.enable_vim_debug then print "'my_hare_setup' has been loaded >>>" end

local HareLSP = {}
HareLSP.hare_search = function()
    --
    -- Get back the hare std lib folder
    --
    local f = assert(io.popen("hare version -vv | rg stdlib 2>/dev/null", 'r'))
    local hare_stdlib_folder = assert(f:read('*a'))
    assert(f:close())

    -- Trim the folder string
    hare_stdlib_folder = hare_stdlib_folder:match "^%s*(.-)%s*$"

    -- print("hare_stdlib_folder: " .. hare_stdlib_folder)

    --
    -- Launch the `live_grep` on `hare_stdlib_folder`
    --
    require('telescope.builtin').live_grep({
        prompt_title = "Hare Standard Library Search",
        prompt_prefix = "  ",
        shorten_path = true,
        cwd = hare_stdlib_folder
    })
end

--
-- Auto command to run when entering into a `.ha` buffer
--
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
    pattern = {"*.ha"},
    callback = function(ev)
        --
        -- Set local buffer keybindings
        --
        vim.api.nvim_buf_set_keymap(0,
            'n',
            '<leader>hs',
            ':lua require(\'my_hare_setup\').hare_search()<CR>',
            {noremap=true, silent=true}
        )
    end
})

return HareLSP
