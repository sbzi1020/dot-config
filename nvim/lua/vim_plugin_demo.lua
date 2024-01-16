if vim.g.enable_vim_debug then print "'vim_plugin_demo' has been reloaded >>>" end

local debug_plugin = false

local vim_plugin_demo = {}

---
local debug_log = function(...)
    if debug_plugin then print("[ vim_plugin_demo ] -", ...) end
end

---
local error_log = function(...)
    if debug_plugin then print("[ vim_plugin_demo ] -", ...) end
end


--[[
-------------------------------------------------------------------
Check whether the binary is there or not:

If `binary_filename` include the path and the path is the relative
path, then plz use `expand()` to wrap that!

If `vim_plugin_demo` doesn't include the path, then plz make sure that
it can be found in the `$PATH`
-------------------------------------------------------------------
--]]
--local binary_filename = "vim_plugin_demo"
local binary_filename = vim.fn.expand("~/Rust/wison-utils/target/debug/wison-utils")
debug_log("binary_filename: " .. binary_filename)

if vim.fn.executable(binary_filename) == 0 then
    error_log("Error: '" .. binary_filename .. "' doesn't exists, plz make sure it can be found in $PATH")
end



--[[
-------------------------------------------------------------------
Bind default keybinding

`<cmd>lua LUA_COMMAND<CR>`

The `<cmd>` means execute the command directly (without changing modes)
-------------------------------------------------------------------
--]]
vim_plugin_demo.set_default_keybindings = function()
    local default_binding_option = { noremap = true }
    local check_health_cmd = '<cmd>lua require(\'vim_plugin_demo\').check_health()<CR>'
    local get_selected_word_cmd = '<cmd>lua require(\'vim_plugin_demo\').get_selected_content(vim.fn.expand("<cword>"))<CR>'

    vim.api.nvim_set_keymap('n', '<leader>ch', check_health_cmd, default_binding_option)
    vim.api.nvim_set_keymap('n', '<leader>gs', get_selected_word_cmd, default_binding_option)

    if debug_plugin then
        debug_log("Already set default keybinding.")
    end
end


--[[
-------------------------------------------------------------------
Get selection content (text/lines)
-------------------------------------------------------------------
--]]
vim_plugin_demo.get_selected_content = function(word_at_cursor)
    --print "'get_selected_content' get invoked"

    --local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
    --local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))

    --local selection_range
    --if csrow < cerow or (csrow == cerow and cscol <= cecol) then
    --    selection_range = csrow - 1, cscol - 1, cerow - 1, cecol
    --else
    --    selection_range = cerow - 1, cecol - 1, csrow - 1, cscol
    --end

    --print(vim.inspect(selection_range))
    --debug_log(word_at_cursor)
end


--[[
-------------------------------------------------------------------
Start a `job`

When calling `vim.fn.jobstart()`, it spawns a “job” using your Rust
binary. A “job” is Neovim speak for attaching a remote plugin to an
instance.

Also, it attaches specific Neovim commands to RPC invocations. For
example, the `:WisonUtils.check_health()` command will send an RPC
message called “check_health” to your Rust code.
-------------------------------------------------------------------
--]]
vim_plugin_demo.start = function()
    -- Only start new job once
    if vim_plugin_demo.job_id ~= nil then return end

    vim_plugin_demo.job_id = vim.fn.jobstart( {binary_filename}, {rpc = true})

    debug_log("Spawning a new job, job id: " .. vim_plugin_demo.job_id)

    vim_plugin_demo.set_default_keybindings()

    --local buffer_init_rpc_request_result = vim_plugin_demo.notify(
    --    "check_health",
    --    --"buf_initialize",
    --    vim.api.nvim_get_current_buf(),
    --    vim.bo.iskeyword
    --)

    --print("Request Result: ", vim_plugin_demo.request(
    --    "buf_initialize",
    --    vim.api.nvim_get_current_buf(),
    --    vim.bo.iskeyword
    --))
end

--[[
-------------------------------------------------------------------
Setup
-------------------------------------------------------------------
--]]
vim_plugin_demo.setup = function(setup_option)
    -- Only setup once
    if vim_plugin_demo.already_setup then return 0 end

    vim_plugin_demo.already_setup = true
    vim_plugin_demo.start()

    debug_log("setup_option: " .. vim.inspect(setup_option or nil))

    debug_log "Setup finished."
end

--[[
-------------------------------------------------------------------
Attach the current buffer to the plugin, it emits `buf_attach_lines`
RPC message
-------------------------------------------------------------------
--]]
local attached = {}

vim_plugin_demo.attach = function(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    if attached[bufnr] then return end

    attached[bufnr] = true

    -- vim.cmd [[autocmd! InsertCharPre <buffer> lua require'rofl'.notify("v_char", vim.api.nvim_get_vvar("char"))]]
    -- vim.cmd [[autocmd! InsertLeave <buffer> lua require'rofl'.notify("insert_leave")]]

    vim.api.nvim_buf_attach(bufnr, true, {
        on_lines = function(_, line_bufnr, _, line_start, line_end, new_end)
            local lines = vim.api.nvim_buf_get_lines(bufnr, line_start, new_end, false)
            -- local mode =  vim.api.nvim_get_mode()["mode"]
            -- vim_plugin_demo.notify("complete")
            -- vim.schedule(function()
                vim_plugin_demo.notify(
                  "buf_attach_lines",

                  line_bufnr,

                  -- Range of start, finish
                  line_start,
                  line_end,

                  -- New text in the lines
                  lines
                )
            -- end)
        end,
    })
end


--[[
-------------------------------------------------------------------
-------------------------------------------------------------------
--]]
vim_plugin_demo.check_health = function()
    vim_plugin_demo.start()

    if debug_plugin then print("check_healt be called >>>") end
    local result = vim.rpcnotify(vim_plugin_demo.job_id, "check_health")
    if debug_plugin then print("check_healt result:", vim.inspect(result)) end
    return result
end


--[[
-------------------------------------------------------------------
-------------------------------------------------------------------
--]]
vim_plugin_demo.request = function(method, ...)
    vim_plugin_demo.start()

    if debug_plugin then print("request be called, method: ", method) end
    local result = vim.rpcrequest(vim_plugin_demo.job_id, method, ...)
    if debug_plugin then print("Result:", method, vim.inspect(result)) end
    return result
end


--[[
-------------------------------------------------------------------
Send RPC message to plugin binary
-------------------------------------------------------------------
--]]
vim_plugin_demo.notify = function(method, ...)
  vim_plugin_demo.start()
  vim.rpcnotify(vim_plugin_demo.job_id, method, ...)
end


--[[
-------------------------------------------------------------------
Send RPC message to plugin binary
-------------------------------------------------------------------
--]]
--vim_plugin_demo._get_context = function(ctx)
--  return vim.tbl_deep_extend("force", {
--    word = vim.fn.expand("<cword>"),
--    cwd = vim.loop.cwd(),
--    bufnr = vim.api.nvim_get_current_buf(),
--  }, ctx)
--end
--
--vim_plugin_demo._get_completions = function(req)
--  return vim_plugin_demo.request(
--    'complete_sync'
--
--    , vim_plugin_demo._get_context(req.context)
--    , req.sources or vim_plugin_demo._get_sources()
--  )
--end

return vim_plugin_demo
