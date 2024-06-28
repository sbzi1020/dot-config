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

        api.node.navigate.parent()
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

    vim.keymap.set('n', 'h', go_up, opts('Up'))

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

vim.keymap.set('n', '<Space>e', '<cmd>NvimTreeToggle<CR>', {noremap=true})

-- [[
-- Toggle tree (open from the given path)
-- ]]
-- function my_toggle_tree()
--     require("nvim-tree.api").tree.toggle({
--         path = "/home/fion/sbzi/",
--         find_file = false,
--         update_root = true,
--         focus = true,
--     })
-- end
-- vim.keymap.set('n', '<Space>e', ':lua my_toggle_tree()<CR>', {noremap=true})
