--[[
This module brings my Emacs `dired` experiences into `Neovim`.

`dired`: "Edit" directory DIRNAME--delete, rename, print, etc. some files in it.
--]]

local enable_debug_print = false

local state = {
    last_dired_buffer_dir = "",
}

-------------------------------------------------------------------------------
-- Get existing dired buffer, or create new one.
-------------------------------------------------------------------------------
local get_dired_buffer = function(create_new_one_if_not_exists)
    local unique_dired_buffer_flag = "i_am_dired_buffer"

    --
    -- Find the existing dired buffer
    --
    local buffer_list = vim.api.nvim_list_bufs()
    local dired_buffer = -1
    for _, buffer_no in ipairs(buffer_list) do
        local get_opts = { buf = buffer_no }

        --
        -- Use `pcall (protected call)` to get the unique buffer flag, avoid
        -- the default error handling: print the error stack and abort.
        --
        -- > Return (true, true) for the dired_buffer
        -- > Return (false, "Key not found: i_am_dired_buffer") for all other buffers
        --
        local _, is_dired_buffer = pcall(
            vim.api.nvim_buf_get_var,
            buffer_no,
            unique_dired_buffer_flag
        )

        local current_buffer_info = {
            no = buffer_no,
            name = vim.api.nvim_buf_get_name(buffer_no),
            type = vim.api.nvim_get_option_value("buftype", get_opts),
            filetype = vim.api.nvim_get_option_value("filetype", get_opts),
            hidden = vim.api.nvim_get_option_value("bufhidden", get_opts),
            swapfile = vim.api.nvim_get_option_value("swapfile", get_opts),
            is_dired_buffer = is_dired_buffer
        }

        if (enable_debug_print) then
            print(">>> [ Dired > get_dired_buffer ] - current buffer opts: " ..
                vim.inspect(current_buffer_info))
        end

        if current_buffer_info.type == "nowrite" and
            current_buffer_info.is_dired_buffer == true then
            if (enable_debug_print) then
                print(">>> Found dired buffer: " .. buffer_no)
            end
            dired_buffer = buffer_no
            return dired_buffer
        end
    end

    --
    -- Create new dired if it's not exists yet
    --
    if dired_buffer == -1 and create_new_one_if_not_exists == true then
        dired_buffer = vim.api.nvim_create_buf(true, false)
        if (enable_debug_print) then
            print(">>> Create new dired buffer: " .. dired_buffer)
        end

        local set_opts = { buf = dired_buffer, }

        vim.api.nvim_set_option_value("buftype", "nowrite", set_opts)
        vim.api.nvim_set_option_value("bufhidden", "hide", set_opts)
        vim.api.nvim_set_option_value("swapfile", false, set_opts)

        -- Allow to modify before finishing the command
        vim.api.nvim_set_option_value("modifiable", true, { buf = dired_buffer })

        -- This enables the bash (shell) syntax color
        local buffer_file_type = "fish"
        vim.api.nvim_set_option_value("filetype", buffer_file_type, set_opts)

        -- Set unique buffer flag
        vim.api.nvim_buf_set_var(dired_buffer, unique_dired_buffer_flag, true)

        --
        -- Setup local buffer keybindings
        --
        local keybinding_opts = {
            -- Only bind to the attached buffer (local binding)
            buffer = dired_buffer,
            silent = true,
            desc = "",
        }

        keybinding_opts.desc = "Dired buffer: Go to parent directory"
        vim.keymap.set('n',
            'h',
            -- function() print(">>> Dired buffer: Go to parent directory") end,
            '<cmd>lua require("my_dired").go_parent_directory()<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Open directory or file"
        vim.keymap.set('n',
            'l',
            -- function() print(">>> Dired buffer: Go to parent directory") end,
            '<cmd>lua require("my_dired").open_directory_or_file()<CR>',
            keybinding_opts)
        vim.keymap.set('n',
            '<CR>',
            -- function() print(">>> Dired buffer: Go to parent directory") end,
            '<cmd>lua require("my_dired").open_directory_or_file()<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Go home"
        vim.keymap.set('n',
            'gh',
            '<cmd>lua require("my_dired").go_to_directory("~/")<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Go config ('~/.config')"
        vim.keymap.set('n',
            'gc',
            '<cmd>lua require("my_dired").go_to_directory("~/.config")<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Go download ('~/Downloads')"
        vim.keymap.set('n',
            'gd',
            '<cmd>lua require("my_dired").go_to_directory("~/Downloads")<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Go temp ('~/temp')"
        vim.keymap.set('n',
            'gt',
            '<cmd>lua require("my_dired").go_to_directory("~/temp")<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Go to sbzi ('~/sbzi')"
        vim.keymap.set('n',
            '<leader>od',
            '<cmd>lua require("my_dired").go_to_directory("~/sbzi")<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Delete current file or directory"
        vim.keymap.set('n',
            'D',
            '<cmd>lua require("my_dired").delete()<CR>',
            keybinding_opts)

        keybinding_opts.desc = "Dired buffer: Create file or directory"
        vim.keymap.set('n',
            'A',
            '<cmd>lua require("my_dired").create()<CR>',
            keybinding_opts)

        --
        -- Return the newly created dired_buffer
        --
        return dired_buffer
    else
        return nil
    end
end

-------------------------------------------------------------------------------
-- Run ls command and fill the dired buffer and switch it in current window
-------------------------------------------------------------------------------
local list_directories_into_dired_buffer = function(dired_buffer, dir)
    --
    -- CANNOT set buffer name to `dir`, otherwise it will be treated as a
    -- built-in directory buffer and be opened into the `netrw` or `nvim-tree`!!!
    --
    -- vim.api.nvim_buf_set_name(dired_buffer, buf_info.dir)

    -- Allow to modify before finishing the command
    vim.api.nvim_set_option_value("modifiable", true, { buf = dired_buffer })

    local ls_result = vim.system({ "ls", "-lhta" }, {
        cwd = dir,
        -- stdin = false,
        -- stdout = true,
        -- stderr = true,

        -- • text: (boolean) Handle stdout and stderr as text. Replaces
        --         `\r\n` with `\n`.
        text = true,

        -- timeout = -1,
    }):wait()

    if (enable_debug_print) then
        print("[ Dired > list_directories_into_dired_buffer ] - ls_result: " ..
            vim.inspect(ls_result))
    end

    if (ls_result.code ~= 0) then
        return
    end

    --
    -- Replace dired_buffer content
    --
    vim.api.nvim_buf_set_lines(
        dired_buffer,
        0, -1, -- Start line: , end line: -1, means the whole buffer content
        false,
        vim.iter({
            "# [ Dired buffer ]",
            dir .. ":",
            "",
            vim.split(ls_result.stdout, "\n")
        }):flatten():totable()
    )

    --
    -- Reset buffer options
    --

    -- Not allow to modify anymore
    vim.api.nvim_set_option_value("modifiable", false, { buf = dired_buffer })

    --
    -- Switch to current window and disable spell checking
    --
    vim.api.nvim_set_current_buf(dired_buffer)
    vim.api.nvim_set_option_value("spell", false, {
        win = vim.api.nvim_get_current_win()
    })

    --
    -- Change working directory to `dir`, so you're able to manipulate files
    -- and directories in the current dired_buffer without problem.
    --
    vim.cmd('lcd ' .. vim.fn.escape(dir, "%# "))

    --
    -- Update internal state
    --
    state = {
        last_dired_buffer_dir = dir
    }
end

-------------------------------------------------------------------------------
-- Go back to parent directory
-------------------------------------------------------------------------------
local go_parent_directory = function()
    --
    -- Get or create the dired buffer
    --
    local dired_buffer = get_dired_buffer(true)

    --
    -- Parent dir
    --
    if (state.last_dired_buffer_dir == "") then return end
    local parent_dir = vim.fs.dirname(state.last_dired_buffer_dir)
    if (enable_debug_print) then
        print("[ Dired > go_parent_directory ] - state.last_dired_buffer_dir: "
            .. vim.inspect(state.last_dired_buffer_dir) .. ", parent_dir: "
            .. parent_dir)
    end

    --
    -- List and update `dired_buffer`
    --
    list_directories_into_dired_buffer(dired_buffer, parent_dir)
end

-------------------------------------------------------------------------------
-- Get back the current item in the dired_buffer, it returns `nil` or the
-- following table:
--
-- {
--
-- }
-------------------------------------------------------------------------------
local get_current_dired_buffer_item = function()
    --
    -- Get the dired buffer
    --
    local dired_buffer = get_dired_buffer(false)
    if dired_buffer == nil then
        if (enable_debug_print) then
            print("[ Dired > get_current_dired_buffer_item ] - dired_buffer is nil")
        end
        return nil
    end

    --
    -- Check whether the dired_buffer is the current buffer or not
    --
    local current_buffer = vim.api.nvim_get_current_buf()
    if current_buffer ~= dired_buffer then
        if (enable_debug_print) then
            print("[ Dired > get_current_dired_buffer_item ] - dired_buffer is NOT the current buffer, abort")
        end
        return nil
    end

    --
    -- Get the current cursor line from the dired_buffer and get the last column
    --
    -- Sample:
    -- -rw-r--r-- 1 fion fion  526 Jul 31 17:20 my_window_utils.lua
    -- drwxr-xr-x 5 fion fion 4.0K Jul 30 19:49 ..
    --
    local current_line = vim.api.nvim_get_current_line()
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - current_line: "
            .. vim.inspect(current_line))
    end

    local dir_cols = vim.split(current_line, " ")
    local dir_cols_len = #dir_cols
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - dir_cols len: "
            .. #dir_cols
            .. ", data:"
            .. vim.inspect(dir_cols))
    end

    if (dir_cols_len < 9) then
        if (enable_debug_print) then
            print("[ Dired > get_current_dired_buffer_item ] - dir_cols_len < 9")
        end
        return nil
    end

    --
    -- Get dir/filename: loop backward to find the `time` col and then join the
    -- rest colums as `item_name`
    --
    local time_col = -1
    for i = 1, #dir_cols do
        local index = #dir_cols + 1 - i
        local temp_col = dir_cols[index]
        local find_result = string.find(temp_col, ":")

        if (enable_debug_print) then
            print(
                string.format(
                    "[ Dired > get_current_dired_buffer_item ] - temp_col: %s, find_result: %s",
                    temp_col,
                    vim.inspect(find_result)
                )
            )
        end

        if (find_result ~= nil) then time_col = index end
    end

    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - time_col: " .. time_col)
    end

    if (time_col == -1) then
        if (enable_debug_print) then
            print("[ Dired > get_current_dired_buffer_item ] - find time col fail.")
        end
        return nil
    end

    local last_items = {}
    for i = time_col + 1, #dir_cols do
        table.insert(last_items, dir_cols[i])
    end
    local item_name = vim.fn.join(last_items, " ")
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - last_items: "
            .. vim.inspect(last_items)
            .. ", item_name: "
            .. vim.inspect(item_name)
        )
    end

    local is_dir_char = string.sub(dir_cols[1], 1, 1)
    local is_dir = is_dir_char == "d"
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - item_name: "
            .. item_name
            .. ", is_dir_char: " .. is_dir_char
            .. ", is_dir: " .. vim.inspect(is_dir))
    end

    return {
        buffer = dired_buffer,
        is_dir = is_dir,
        item_name = item_name
    }
end

-------------------------------------------------------------------------------
-- Go into the current directory or open file
-------------------------------------------------------------------------------
local open_directory_or_file = function()
    local current_item = get_current_dired_buffer_item()
    if (current_item == nil) then return end

    --
    -- Don't handle the following cases
    --
    if current_item.is_dir and current_item.item_name == "." then
        if (enable_debug_print) then
            print("[ Dired > open_directory_or_file ] - don't handle '.' directory")
        end
        return
    end

    if (state.last_dired_buffer_dir == "") then
        if (enable_debug_print) then
            print("[ Dired > open_directory_or_file ] - state.last_dired_buffer_dir is empty.")
        end
        return
    end

    --
    -- Parent dir case: ..
    --
    if current_item.is_dir and current_item.item_name == ".." then
        local parent_dir = vim.fs.dirname(state.last_dired_buffer_dir)
        if (enable_debug_print) then
            print("[ Dired > open_directory_or_file ] - state.last_dired_buffer_dir: "
                .. vim.inspect(state.last_dired_buffer_dir)
                .. ", parent_dir: "
                .. parent_dir)
        end

        list_directories_into_dired_buffer(current_item.buffer, parent_dir)
        --
        -- Directories
        --
    elseif current_item.is_dir and current_item.item_name ~= ".." then
        local open_dir = vim.fs.joinpath(state.last_dired_buffer_dir, current_item.item_name)
        if (enable_debug_print) then
            print("[ Dired > open_directory_or_file ] - open_dir: "
                .. open_dir)
        end

        list_directories_into_dired_buffer(current_item.buffer, open_dir)
        --
        -- Files: open it in a new buffer
        --
    elseif not current_item.is_dir and current_item.item_name ~= "" then
        local open_file = vim.fs.joinpath(state.last_dired_buffer_dir, current_item.item_name)
        if (enable_debug_print) then
            print("[ Dired > open_directory_or_file ] - open_file: "
                .. open_file)
        end

        local new_file_buffer = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_set_current_buf(new_file_buffer)
        vim.cmd.edit(vim.fn.escape(open_file, "%# "))
    end
end
-- open_directory_or_file()


-------------------------------------------------------------------------------
-- Delete
-------------------------------------------------------------------------------
local delete = function()
    local current_item = get_current_dired_buffer_item()
    if (current_item == nil) then return end

    --
    -- Don't handle the following cases
    --
    if current_item.is_dir and (current_item.item_name == "." or current_item.item_name == "..") then
        if (enable_debug_print) then
            print("[ Dired > delete ] - don't handle '.' or '..' directory")
        end
        return
    end

    if (state.last_dired_buffer_dir == "") then
        if (enable_debug_print) then
            print("[ Dired > delete ] - state.last_dired_buffer_dir is empty.")
        end
        return
    end

    --
    -- Prompt before deletion
    --
    local deletion_prompt = ""
    if (current_item.is_dir) then
        deletion_prompt = string.format(
            "Are you sure to delete '%s' and all its contents? (y/n)",
            current_item.item_name)
    else
        deletion_prompt = string.format(
            "Are you sure to delete '%s'? (y/n)", current_item.item_name)
    end

    -- --
    -- -- Show the prompt popup to ask:
    -- -- The downside of this it that user needs to press `i` before typing `y`!!!
    -- --
    -- vim.ui.input({ prompt = deletion_prompt }, function(input)
    --     if (enable_debug_print) then
    --         print("[ Dired > delete ] - input: " .. vim.inspect(input))
    --     end
    --
    --     local user_input = input:match "^%s*(.-)%s*$"
    --     if (user_input == 'y' or user_input == 'Y') then
    --         print(">>> Yes, delete the '" .. current_item.item_name .. "'.")
    --     end
    -- end)

    local user_input = vim.fn.input({ prompt = deletion_prompt })
    user_input = user_input:match("^%s*(.-)%s*$")
    if (enable_debug_print) then
        print("[ Dired > delete ] - user_input: " .. vim.inspect(user_input))
    end

    if (user_input == 'y' or user_input == 'Y') then
        if (enable_debug_print) then
            print("[ Dired > delete ] - delete '" .. current_item.item_name .. "'.")
        end

        local result = vim.system({ "rm", "-rf", current_item.item_name }, {
            cwd = state.last_dired_buffer_dir,
            text = true,
        }):wait()

        if (enable_debug_print) then
            print("[ Dired > delete ] - result: " ..
                vim.inspect(result))
        end

        -- Show erorr if failed
        if (result.code ~= 0) then
            if (enable_debug_print) then
                print("[ Dired > delete ] - delete failed: " ..
                    vim.inspect(result.stderr))
            end
            -- Otherwise, refresh dired_buffer
        else
            list_directories_into_dired_buffer(
                current_item.buffer,
                state.last_dired_buffer_dir
            )
        end
    end
end

-------------------------------------------------------------------------------
-- Create file or directory
-------------------------------------------------------------------------------
local create = function()
    --
    -- Get the dired buffer
    --
    local dired_buffer = get_dired_buffer(false)
    if dired_buffer == nil then
        if (enable_debug_print) then
            print("[ Dired > create ] - dired_buffer is nil")
        end
        return nil
    end

    --
    -- Check whether the dired_buffer is the current buffer or not
    --
    local current_buffer = vim.api.nvim_get_current_buf()
    if current_buffer ~= dired_buffer then
        if (enable_debug_print) then
            print("[ Dired > create ] - dired_buffer is NOT the current buffer, abort")
        end
        return nil
    end

    if (state.last_dired_buffer_dir == "") then
        if (enable_debug_print) then
            print("[ Dired > create ] - state.last_dired_buffer_dir is empty.")
        end
        return
    end

    --
    -- Prompt before deletion
    --
    local create_prompt = "Create file or directory (end with '/')"
    local user_input = vim.fn.input({ prompt = create_prompt })
    local item_name = user_input:match("^%s*(.-)%s*$")
    if (item_name == "") then return end

    local item_len = string.len(item_name)
    local is_dir_char = string.sub(item_name, item_len, item_len)
    local is_dir = is_dir_char == "/"
    if (enable_debug_print) then
        print("[ Dired > create ] - item_name: "
            .. vim.inspect(item_name)
            .. ", is_dir: " .. vim.inspect(is_dir))
    end

    local cmd = {}
    if (is_dir) then
        cmd = { "mkdir", string.sub(item_name, 1, item_len - 1) }
    else
        cmd = { "touch", item_name }
    end
    if (enable_debug_print) then
        print("[ Dired > create ] - create cmd: " .. vim.inspect(cmd))
    end

    local result = vim.system(cmd, {
        cwd = state.last_dired_buffer_dir,
        text = true,
    }):wait()

    if (enable_debug_print) then
        print("[ Dired > create ] - result: " ..
            vim.inspect(result))
    end

    -- Show erorr if failed
    if (result.code ~= 0) then
        if (enable_debug_print) then
            print("[ Dired > create ] - create failed: " ..
                vim.inspect(result.stderr))
        end
        -- Otherwise, refresh dired_buffer
    else
        list_directories_into_dired_buffer(
            dired_buffer,
            state.last_dired_buffer_dir
        )
    end
end

-------------------------------------------------------------------------------
-- Go back to parent directory
-------------------------------------------------------------------------------
local go_to_directory = function(dir)
    --
    -- Get or create the dired buffer
    --
    local dired_buffer = get_dired_buffer(true)

    --
    -- Expand dir
    --
    local expanded_dir = vim.fn.expand(dir)
    if (expanded_dir == "") then
        if (enable_debug_print) then
            print("[ Dired > go_to_directory ] - failed to expand directory: "
                .. vim.inspect(dir))
            return
        end
    end

    --
    -- List and update `dired_buffer`
    --
    list_directories_into_dired_buffer(dired_buffer, expanded_dir)
end

-------------------------------------------------------------------------------
--
-------------------------------------------------------------------------------
local open = function()
    --
    -- Get or create the dired buffer
    --
    local dired_buffer = get_dired_buffer(true)

    --
    -- Get current buffer info
    --
    local buf_filename = vim.api.nvim_buf_get_name(0)
    local buf_info = {
        fullpath_filename = buf_filename,
        dir = vim.fs.dirname(buf_filename)
    }

    if (buf_filename == "") then buf_info.dir = vim.fn.getcwd() end
    if (enable_debug_print) then
        print("[ Dired > open ] - buf_info: " .. vim.inspect(buf_info))
    end

    --
    -- List and update `dired_buffer`
    --
    list_directories_into_dired_buffer(dired_buffer, buf_info.dir)
end

local test = function()
    -- local buffer_var_name = "is_dired_buffer"
    -- vim.api.nvim_buf_set_var(0, buffer_var_name, true)
    --
    --
    -- local buffer_list = vim.api.nvim_list_bufs()
    -- local dired_buffer = -1
    -- for _, buffer_no in ipairs(buffer_list) do
    --     local get_opts = { buf = buffer_no }
    --
    --     local status, is_dired_buffer = pcall(
    --         vim.api.nvim_buf_get_var,
    --         buffer_no,
    --         buffer_var_name
    --     )
    --     -- print(">>> status: "..vim.inspect(status)
    --     --     ..", "..buffer_var_name..": "
    --     --     .. vim.inspect(is_dired_buffer))
    --
    --     local current_buffer_info = {
    --         no = buffer_no,
    --         name = vim.api.nvim_buf_get_name(buffer_no),
    --         type = vim.api.nvim_get_option_value("buftype", get_opts),
    --         filetype = vim.api.nvim_get_option_value("filetype", get_opts),
    --         hidden = vim.api.nvim_get_option_value("bufhidden", get_opts),
    --         swapfile = vim.api.nvim_get_option_value("swapfile", get_opts),
    --         first_line = vim.api.nvim_buf_get_lines(buffer_no, 0, 1, false),
    --         is_dired_buffer = is_dired_buffer
    --     }
    --
    --     print(">>> [ Dired > get_dired_buffer ] - current buffer opts: " ..
    --         vim.inspect(current_buffer_info))
    -- end

    --
    -- Get the current cursor line from the dired_buffer and get the last column
    --
    -- Sample:
    -- -rw-r--r-- 1 fion fion  526 Jul 31 17:20 my_window_utils.lua
    -- drwxr-xr-x 5 fion fion 4.0K Jul 30 19:49 ..
    --
    local current_line = "-rw-r--r-- 1 fion fion  526 Jul 31 17:20 my_window_utils cool"
    -- local current_line = "-rw-r--r-- 1 fion fion  526 Jul 31 17:20 my_window_utils.lua"
    -- local current_line = "drwxr-xr-x 5 fion fion 4.0K Jul 30 19:49 .."
    -- local current_line = "drwxr-xr-x 5 fion fion 4.0K Jul 30 19:49 Get Start"

    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - current_line: "
            .. vim.inspect(current_line))
    end

    local dir_cols = vim.split(current_line, " ")
    local dir_cols_len = #dir_cols
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - dir_cols len: "
            .. #dir_cols
            .. ", data:"
            .. vim.inspect(dir_cols))
    end

    if (dir_cols_len < 9) then
        if (enable_debug_print) then
            print("[ Dired > get_current_dired_buffer_item ] - dir_cols_len < 9")
        end
        return nil
    end

    --
    -- Get dir/filename: loop backward to find the `time` col and then join
    -- the rest colums as `item_name`
    --
    local time_col = -1
    for i = 1, #dir_cols do
        local index = #dir_cols + 1 - i
        local temp_col = dir_cols[index]
        local find_result = string.find(temp_col, ":")
        print(string.format("temp_col: %s, find_result: %s", temp_col, vim.inspect(find_result)))
        if (find_result ~= nil) then time_col = index end
    end
    print(">>> time_col: " .. time_col)
    if (time_col == -1) then
        print("[ Dired > get_current_dired_buffer_item ] - find time col fail.")
        return nil
    end

    local last_items = {}
    for i = time_col + 1, #dir_cols do
        table.insert(last_items, dir_cols[i])
    end
    print(">>> last_items: " .. vim.inspect(last_items))
    local item_name = vim.fn.join(last_items, " ")
    print(">>> item_name: " .. vim.inspect(item_name))

    local is_dir_char = string.sub(dir_cols[1], 1, 1)
    local is_dir = is_dir_char == "d"
    if (enable_debug_print) then
        print("[ Dired > get_current_dired_buffer_item ] - item_name: "
            .. item_name
            .. ", is_dir_char: " .. is_dir_char
            .. ", is_dir: " .. vim.inspect(is_dir))
    end
end
-- test()


-------------------------------------------------------------------------------
-- Default keybindings
-------------------------------------------------------------------------------
vim.keymap.set(
    "n",
    "<C-c>j",
    "<cmd>lua require('my_dired').open()<CR>",
    {
        silent = true,
        desc = "Open file explorer with current buffer directory"
    }
)

return {
    open = open,
    go_parent_directory = go_parent_directory,
    go_to_directory = go_to_directory,
    open_directory_or_file = open_directory_or_file,
    create = create,
    delete = delete,
}
