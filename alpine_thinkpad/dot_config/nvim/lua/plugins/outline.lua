-------------------------------------------------------------------------------
-- Outline support
-- 
-- Make sure to copy `hare.lua` to
-- `$HOME/.local/share/nvim/lazy/outline.nvim/lua/outline/providers/hare.lua`
-------------------------------------------------------------------------------
return {
    'hedyhli/outline.nvim',
    config = function()
        require("outline").setup({
            show_cursorline = true,
            hide_cursor = true,
            center_on_jump = true,
            providers = {
                priority = { 'lsp', 'markdown', 'hare', 'norg' },

                -- Configuration for each provider (3rd party providers are supported)
                lsp = {
                    -- Lsp client names to ignore
                    blacklist_clients = {},
                },

                markdown = {
                    -- List of supported ft's to use the markdown provider
                    filetypes = {'markdown'},
                },

                -- `config` param that passes into the `supports_buffer` function
                hare = {
                    -- List of supported ft's to use the markdown provider
                    filetypes = {'ha'},

                    show_function = true,
                    show_type = true,
                    show_variable = true,
                },
            },
        })

        vim.keymap.set("n",
            "<leader>im",
            "<cmd>Outline<CR>",
            {
                silent = true,
                desc = "Toggle Outline",
            })
    end
}
