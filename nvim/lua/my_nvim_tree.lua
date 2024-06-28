if vim.g.enable_vim_debug then print "'my_nvim_tree' has been loaded >>>" end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local function my_on_attach(bufnr)
    local api = require "nvim-tree.api"
    
    local function opts(desc)
      return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    local function go_up()
        api.tree.change_root_to_parent()
        api.tree.collapse_all()
    end

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
    
    -- Navigation
    vim.keymap.set('n', 'l', api.tree.change_root_to_node, opts('CD'))
    -- vim.keymap.set('n', 'O', api.node.open.tab, opts("Open"))
    vim.keymap.set('n', 'o', api.node.navigate.parent, opts("parent"))
    vim.keymap.set('n', 'gs', go_home, opts("Go Home"))
    vim.keymap.set('n', 'gd', go_download, opts("Go download"))
    vim.keymap.set('n', 'gn', go_note, opts("Go notes"))

    -- vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
    vim.keymap.set('n', 'h', go_up, opts('Up'))
    -- vim.keymap.set('n', 'h',       api.node.navigate.parent,            opts('Parent Directory'))

    -- Open
    vim.keymap.set('n', '<CR>', api.node.open.no_window_picker, opts('Open'))

    -- Folder related
    vim.keymap.set('n', 'a',  api.fs.create, opts('Create File Or Directory'))
    vim.keymap.set('n', 'C',  api.fs.copy.node, opts('Copy'))
    vim.keymap.set('n', 'P',  api.fs.paste, opts('Paste'))
    vim.keymap.set('n', 'R',  api.fs.rename, opts('Rename'))
    vim.keymap.set('n', 'D',  api.fs.remove, opts('Delete'))
    vim.keymap.set('n', 'X',  api.fs.cut, opts('Cut'))
    vim.keymap.set('n', 'yp', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
    vim.keymap.set('n', 'E',  api.tree.expand_all, opts('Expand All'))
    vim.keymap.set('n', 'W',  api.tree.collapse_all, opts('Collapse'))

    -- Show keybindingds
    vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

local loaded_nvim_tree = Reload_package("nvim-tree")
loaded_nvim_tree.setup({
    on_attach = my_on_attach,
    sync_root_with_cwd = true,
    sort = {
        sorter = "case_sensitive",
    },
    view = {
        width = 30,
    },
    renderer = {
        group_empty = true,
        indent_markers = {
            icons =   {
                corner = "└",
                edge = "│",
                item = "│",
                bottom = "─",
                none = " ",
            },
        }
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

-- vim.cmd([[
--     :hi      NvimTreeExecFile    guifg=#ffa0a0
--     :hi      NvimTreeSpecialFile guifg=#ff80ff gui=underline
--     :hi      NvimTreeSymlink     guifg=Yellow  gui=italic
--     :hi link NvimTreeImageFile   Title
-- ]])


vim.keymap.set('n', '<Space>e', '<cmd>NvimTreeToggle<CR>', {noremap=true})

-- loaded_nvim_tree.setup {
--     disable_netrw = true,
--     hijack_netrw = true,
--     open_on_setup = false,
--     ignore_ft_on_setup = {
--         "startify",
--         "dashboard",
--         "alpha",
--     },
--     auto_close = true,
--     open_on_tab = false,
--     hijack_cursor = false,
--     update_cwd = true,
--     update_to_buf_dir = {
--         enable = true,
--         auto_open = true,
--     },
--     diagnostics = {
--         enable = true,
--         icons = {
--             hint = "",
--             info = "",
--             warning = "",
--             error = "",
--         },
--     },
--     update_focused_file = {
--         enable = true,
--         update_cwd = true,
--         ignore_list = {},
--     },
--     system_open = {
--         cmd = nil,
--         args = {},
--     },
--     filters = {
--         dotfiles = false,
--         custom = {},
--     },
--     git = {
--         enable = true,
--         ignore = true,
--         timeout = 500,
--     },
--     view = {
--         width = 40,
--         height = 30,
--         hide_root_folder = false,
--         side = "left",
--         auto_resize = true,
--         mappings = {
--             custom_only = false,
--             -- list = {
--             --     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
--             --     { key = "h", cb = tree_cb "close_node" },
--             --     { key = "v", cb = tree_cb "vsplit" },
--             -- },
--         },
--         number = false,
--         relativenumber = false,
--     },
--     trash = {
--         cmd = "trash",
--         require_confirm = true,
--     },
--     quit_on_open = 0,
--     git_hl = 1,
--     disable_window_picker = 0,
--     root_folder_modifier = ":t",
--     show_icons = {
--         git = 1,
--         folders = 1,
--         files = 1,
--         folder_arrows = 1,
--         tree_width = 30,
--     },
-- }
