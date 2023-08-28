if vim.g.enable_vim_debug then print "'my_plugins' has been loaded >>>" end

--[[
Automatically install packer

If you want to test this functionality, then you need remove the exists folder
by running:

rm -rf $HOME/.local/share/nvim/site/pack
--]]
local fn = vim.fn

-- `data` usually point to `$HOME/.local/share/nvim`
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
-- print("install_path: "..install_path)

local packer_first_installed = false
if fn.empty(fn.glob(install_path)) > 0 then
  packer_first_installed = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    -- non_interactive = true,
    -- open_fn = function()
    --   return require("packer.util").float { border = "rounded" }
    -- end,
  },
}

--[[
Every time save `lua/my_plugins.lua`, run the `:PackerSync` command to make sure all
plugins are up-to-date.
--]]
vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = { 'my_plugins.lua' },
    command = "source <afile> | PackerSync",
    group = vim.api.nvim_create_augroup('PackerUserConfig', { clear = true })
})

-- Install your plugins here
return packer.startup(function(use)
    ---- Have packer manage itself
    use "wbthomason/packer.nvim"

    --[[
    Syntax highlight modules
    --]]
    use "norcalli/nvim-colorizer.lua"
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/playground' } -- Make sure enable it in `my_treesitter.lua`

    --[[
    Status line
    --]]
    use 'kyazdani42/nvim-web-devicons'
    use 'edkolev/tmuxline.vim'
    use { 'glepnir/galaxyline.nvim', branch = 'main' }

    --[[
    File explore
    --]]
    --use "kyazdani42/nvim-tree.lua"

    --[[
    Look and feel modules
    --]]
    use 'lukas-reineke/indent-blankline.nvim'

    --[[
    Editing improvement modules
    --]]
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'jiangmiao/auto-pairs'
    use 'junegunn/goyo.vim'

    --[[
    For markdown plugin, before any update from repo README, plz run the 
    following command to install:

    ```
    cd ~/.local/share/nvim/site/pack/packer/start/
    rm -rf markdown-preview.nvim
    git clone https://github.com/iamcco/markdown-preview.nvim.git
    cd markdown-preview.nvim
    yarn install

    // After finishing all of those, uncomment the below `use` command
    ```
    --]]
    use {'iamcco/markdown-preview.nvim'}

    --[[
    Run neovim in browser

    Make sure read descrption in `my_firenvim.lua` if it doesn't work!!!
    Make sure read descrption in `my_firenvim.lua` if it doesn't work!!!
    Make sure read descrption in `my_firenvim.lua` if it doesn't work!!!
    --]]
    use {'glacambre/firenvim', run = function() vim.fn['firenvim#install'](0) end }

    --[[
    Fuzzy find and ripgrep searching
    --]]
    use 'nvim-lua/popup.nvim'           -- An implementation of the Popup API from vim in Neovim.
    use 'nvim-lua/plenary.nvim'         -- Lua functions many plugins rely on
    use 'nvim-telescope/telescope.nvim'
    -- Enable fzf search syntax
    use {
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }
    use { 'dhruvmanila/telescope-bookmarks.nvim', tag = '*' } -- Search from browser bookmark

    --[[
    Comment and uncomment for all languages
    --]]
    use 'terrortylor/nvim-comment'

    --[[
    Color Scheme
    --]]
    --use 'navarasu/onedark.nvim'

    --[[
    LSP related
    --]]

    -- Standard LSP config
    -- You can run `:LspInfo` to show attached and active client info at any given time.
    use 'neovim/nvim-lspconfig'


    -- Only work for `rust-analyzer` for getting the best LSP experience.
    use 'simrat39/rust-tools.nvim'

    -- CPP, clangd extension
    use 'p00f/clangd_extensions.nvim'

    -- Zig
    use 'ziglang/zig.vim'

    -- Auto completion
    use 'hrsh7th/nvim-cmp'      -- A completion engine plugin for neovim written in Lua.
    use 'hrsh7th/cmp-nvim-lsp'  -- nvim-cmp source for neovim's built-in language server client.
    use 'hrsh7th/cmp-nvim-lua'  -- nvim-cmp source for neovim Lua API.
    use 'hrsh7th/cmp-buffer'    -- nvim-cmp source for buffer words.
    use 'hrsh7th/cmp-path'      -- nvim-cmp source for filesystem paths.
    use 'hrsh7th/cmp-cmdline'   -- nvim-cmp source for vim's cmdline.


    -- Snippet
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    --[[
    ChatGPT related
    --]]
    use({
        "jackMort/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup()
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        },
        config = function()
            require("chatgpt").setup({
                api_key_cmd = "echo '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'"
            })
        end,
    })

    --[[
    Automatically set up your configuration after cloning packer.nvim
    Put this at the end after all plugins
    --]]
    if packer_first_installed then
        require("packer").sync()
    end
end)
