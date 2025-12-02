-------------------------------------------------------------------------------
-- NvimTree attach function to controll keybindings via 'nvim-tree-api'
-------------------------------------------------------------------------------
local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    --
    -- Go back to parent folder
    --
    local function go_up()
        api.tree.change_root_to_parent()

        api.node.navigate.parent()
        api.tree.collapse_all()
    end

    --
    -- Go back specific folder
    --
    local function go_home()
        api.tree.change_root("~/sbzi")
    end

    local function go_download()
        api.tree.change_root("~/Downloads")
    end
    local function go_note()
        api.tree.change_root("~/sbzi/personal/denote/")
    end

    -- default mappings
    -- api.config.mappings.default_on_attach(bufnr)

    --
    -- Navigation
    --
    vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
    -- vim.keymap.set('n', 'O', api.node.open.tab, opts("Open"))
    vim.keymap.set('n', 'o', api.node.navigate.parent, opts("parent"))
    vim.keymap.set('n', 'gs', go_home, opts("Go Home"))
    vim.keymap.set('n', 'gd', go_download, opts("Go download"))
    vim.keymap.set('n', 'gn', go_note, opts("Go notes"))

    vim.keymap.set('n', 'h', go_up, opts('Up'))

    --
    -- Open
    --
    vim.keymap.set('n', '<CR>', api.node.open.no_window_picker, opts('Open'))
    -- vim.keymap.set('n', '<CR>', api.node.open.vertical, opts('Open'))

    --
    -- Folder related
    --
    vim.keymap.set('n', 'A',  api.fs.create, opts('Create File Or Directory'))
    vim.keymap.set('n', 'C',  api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'P',  api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'R',  api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'D',  api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'X',  api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'Y', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'E',  api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'W',  api.tree.collapse_all, opts('Collapse'))

    --
    -- Show keybindingds
    --
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    enabled = true,
    config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require("nvim-tree").setup({
            on_attach = my_on_attach,
            sync_root_with_cwd = true,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                width = 40,
            },
            renderer = {
                group_empty = true,
                indent_markers = {
                    enable = true,
                    inline_arrows = true,
                    icons = {
                        corner = "└",
                        edge = "│",
                        item = "│",
                        bottom = "─",
                        none = " ",
                    },
                },
                icons = {
                    show = {
                        git = false,
                    }
                },
                indent_width = 4,
            },
            filters = {
                dotfiles = false,
            },
            actions = {
                expand_all = {
                    exclude = { ".git", "target", "build", 'node_modules' },
                },
            },
        })

--        vim.keymap.set('n',
--            '<leader>ee',
--            '<cmd>NvimTreeToggle<CR>',
--            {
--                silent = true,
--                desc = "NvimTree toggle",
--            })
--
        vim.keymap.set('n',
            '<leader>ee',
            '<cmd>NvimTreeFindFileToggle<CR>',
            {
                silent = true,
                desc = "NvimTree toggle on current file",
            })

        vim.keymap.set('n',
            '<leader>er',
            '<cmd>NvimTreeRefresh<CR>',
            {
                silent = true,
                desc = "NvimTree Refresh",
            })
    end
}
