if vim.g.enable_vim_debug then print "'my_nvim_comment' has been reloaded >>>" end

--[[
-----------------------------------------------------------------------
terrortylor/nvim-comment

After enable these:
    create_mappings = true,
    operator_mapping = "cm",

Then can do `cm{motion}`, for example:

    `cml`   - Toggle Comment line
    `cmi{`  - Toggle Comment in {
    `cmi(`  - Toggle Comment in {
    `cmi[`  - Toggle Comment in {
-----------------------------------------------------------------------
--]]
local loaded_package = Reload_package('nvim_comment')
loaded_package.setup({
    -- Linters prefer comment and line to have a space in between markers
    marker_padding = true,
    -- should comment out empty or whitespace only lines
    comment_empty = false,
    -- Should key mappings be created
    create_mappings = true,
    -- Normal mode mapping left hand side
    -- line_mapping = "<leader>cl",
    -- Visual/Operator mapping left hand side
    operator_mapping = "cm",
    -- Hook function to call before commenting takes place
    hook = nil
})
