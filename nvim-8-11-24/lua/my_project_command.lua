--[[
This module allows you to show a command list picker to run the selected command
in the terminal buffer inside the right-splitted window, the terminal buffer will
be reused if it exists.
--]]

local enable_debug_print = false

-- `pickers`: main module which is used to create a new picker.
local pickers = require "telescope.pickers"

-- `finders`: provides interfaces to fill the picker with items.
local finders = require "telescope.finders"

-- `config`: `values` table which holds the user's configuration.
local conf = require("telescope.config").values

--
-- `actions`: holds all actions that can be mapped by a user. We also need it
-- to access the default action so we can replace it. Also see
-- `:help telescope.actions`
--
local actions = require("telescope.actions")

--
-- `action_state`: gives us a few utility functions we can use to get the
-- current picker, current selection or current line. Also see
-- `:help telescope.actions.state`
--
local action_state = require("telescope.actions.state")

--
-- Command list (remove the `local` if you want the `CMD_LIST` to become global)
--
local CMD_LIST = {}
-- table.insert(CMD_LIST, "zig build run")
-- table.insert(CMD_LIST, "zig build run -Drelease")
-- for index, value in ipairs(CMD_LIST) do
--     print(">>> CMD_LIST[" .. index .. "]: " .. value)
-- end


-------------------------------------------------------------------------------
-- Get back the right-splitted window, return `nil` if not exists
-------------------------------------------------------------------------------
local get_most_right_splitted_window = function()
    local win_list = vim.api.nvim_list_wins()
    if (enable_debug_print) then
        print(">>> [ Project_command > get_most_right_splitted_window ] - win_list: " ..
            vim.inspect(win_list))
    end

    local most_right_win = nil
    local last_most_right_win_column = -1
    for _, win in ipairs(win_list) do
        -- win_pos: { row, col }
        local win_pos = vim.api.nvim_win_get_position(win)

        if (enable_debug_print) then
            print(">>> [ Project_command > get_most_right_splitted_window ] - win: " ..
                win .. ", pos: " .. vim.inspect(win_pos))
        end

        --
        -- The most right window means:
        --
        -- 1. row is 0 but col > 0
        -- 2. col is the biggest value
        --
        if win_pos[1] == 0 and win_pos[2] > 0 and win_pos[2] > last_most_right_win_column then
            most_right_win = win
            last_most_right_win_column = win_pos[2]
        end
    end

    return most_right_win
end

--
-- Uncomment this and run `:luafile %` to test this function
--
-- print(vim.inspect(get_most_right_splitted_window()))


-------------------------------------------------------------------------------
-- Get command buffer, create it if it's not exists yet
-------------------------------------------------------------------------------
local get_command_buffer = function()
    function string_endwith(check_str, ending)
        return ending == "" or check_str:sub(- #ending) == ending
    end

    --
    -- Find the existing command buffer
    --
    local buffer_list = vim.api.nvim_list_bufs()
    local command_buffer = -1
    for _, buffer_no in ipairs(buffer_list) do
        local get_opts = { buf = buffer_no }
        local current_buffer_opts = {
            no = buffer_no,
            name = vim.api.nvim_buf_get_name(buffer_no),
            type = vim.api.nvim_get_option_value("buftype", get_opts),
            filetype = vim.api.nvim_get_option_value("filetype", get_opts),
            hidden = vim.api.nvim_get_option_value("bufhidden", get_opts),
            swapfile = vim.api.nvim_get_option_value("swapfile", get_opts),
        }

        if (enable_debug_print) then
            print(">>> [ Project command > get_command_buffer ] - current buffer opts: " ..
                vim.inspect(current_buffer_opts))
        end

        if string_endwith(current_buffer_opts.name, "Command result") == true and
            current_buffer_opts.type == "nowrite" and
            current_buffer_opts.filetype == "fish" and
            current_buffer_opts.hidden == "hide" and
            current_buffer_opts.swapfile == false then
            if (enable_debug_print) then
                print(">>> [ Project command > get_command_buffer ] - Found command buffer: " .. buffer_no)
            end
            command_buffer = buffer_no
        end
    end

    if (command_buffer ~= -1) then
        return command_buffer
    end

    --
    -- Create new command buffer if it's not exists yet
    --
    if command_buffer == -1 then
        command_buffer = vim.api.nvim_create_buf(true, false)
        if (enable_debug_print) then
            print(">>> [ Project command > get_command_buffer ] - create new command buffer: " ..
                command_buffer)
        end

        local set_opts = { buf = command_buffer, }

        vim.api.nvim_buf_set_name(command_buffer, "Command result")
        vim.api.nvim_set_option_value("buftype", "nowrite", set_opts)
        vim.api.nvim_set_option_value("bufhidden", "hide", set_opts)
        vim.api.nvim_set_option_value("swapfile", false, set_opts)

        -- Allow to modify before finishing the command
        vim.api.nvim_set_option_value("modifiable", true, { buf = command_buffer })

        -- This enables the bash (shell) syntax color
        local buffer_file_type = "fish"
        vim.api.nvim_set_option_value("filetype", buffer_file_type, set_opts)
    end

    return command_buffer
end


-------------------------------------------------------------------------------
-- Run command and fill the command buffer and switch it in current window
-------------------------------------------------------------------------------
local run_command_and_write_to_buffer = function(command_buffer, cmd)
    -- Allow to modify before finishing the command
    vim.api.nvim_set_option_value("modifiable", true, { buf = command_buffer })

    if (enable_debug_print) then
        print(">>> [ Project command > run_command_and_write_to_buffer ] - command buffer: " ..
            command_buffer .. "\n, cmd: " .. vim.inspect(cmd))
    end

    --
    -- Replace the output buffer content to running command and force to redraw
    -- to see the buffer change
    --
    vim.api.nvim_buf_set_lines(
        command_buffer,
        0, -1, -- Start line: 0, end line: -1, means the whole buffer content
        false,
        { "Running command: " .. cmd }
    )
    vim.api.nvim__redraw({
        buf = command_buffer,
        flush = true,
        valid = false,
    })

    --
    -- Run cmd and send output to the command buffer
    --
    local command_output = vim.fn.system(cmd)
    vim.api.nvim_buf_set_lines(
        command_buffer,
        0, -1, -- Start line: 0, end line: -1, means the whole buf
        false,
        vim.iter({
            "Command: " .. cmd,
            "-------------------------------------------------------",
            "",
            vim.split(command_output, "\n")
        }):flatten():totable()
    )

    --
    -- Reset output buffer options
    --
    local update_set_opts = { buf = command_buffer }
    vim.api.nvim_set_option_value("modifiable", false, update_set_opts)
end

-------------------------------------------------------------------------------
-- Does the same thing with what `execute_command` does except:
--
-- 1. Use normal buffer instead of terminal buffer
--
-- 2. Reset back to not allowed to modify after the command has been done
--
-- 3. Reset back to unmodified to avoid a warnning when closing the buffer
--
-------------------------------------------------------------------------------
local execute_command_v2 = function(cmd)
    local splitted_win = get_most_right_splitted_window()

    local command_buffer = get_command_buffer()

    -- Create new split window with output buffer if splitted_win is `nil`
    if (splitted_win == nil) then
        local new_window_become_current_window = true
        splitted_win = vim.api.nvim_open_win(command_buffer,
            new_window_become_current_window,
            {
                split = 'right',
                win = 0,
            }
        )
    else
        -- Otherwise, Switch output buffer to splitted_win
        vim.api.nvim_win_set_buf(splitted_win, command_buffer)
    end

    run_command_and_write_to_buffer(command_buffer, cmd)
end


-------------------------------------------------------------------------------
-- Show the command picker
-------------------------------------------------------------------------------
local run = function(opts)
    opts = opts or {}
    local cmd_picker = pickers.new(opts, {
        prompt_title = "Project commands",
        results_title = "Command history",

        layout_config = {
            -- Popup window settings
            width = 0.50,
            height = 0.40,

            -- Prompt (Search bar) position
            prompt_position = "top",
        },

        --
        -- `finder` is a required field that needs to be set to the result of
        -- a `finders` function. In this case we take `new_table` which allows
        -- us to define a static set of values, `results`, which is an array of
        -- elements. It doesn't have to be an array of strings, it can also be
        -- an array of tables.
        --
        -- Also, you can use `vim.fn.getcompletion("", COMPLETION_TYPE_HERE)`
        -- to get back all available values for the given type, e.g.:
        --
        -- > Get back all supported colorschemes:
        --   vim.fn.getcompletion("", "color")
        --
        -- > Get back all directories in pwd:
        --   vim.fn.getcompletion("", "dir")
        --
        -- > Get back all directories and files in pwd:
        --   vim.fn.getcompletion("", "file")
        --
        -- > Get back all directories and files in global var: path
        --   vim.fn.getcompletion("", "file_in_path")
        --
        -- > Get back all env var names
        --   vim.fn.getcompletion("", "environment")
        --
        -- > Get back all supported options:
        --   vim.fn.getcompletion("", "option")
        --
        -- > Get back all commands in your $PATH
        --   vim.fn.getcompletion("", "shellcmd")
        --
        -- > Get back all compilers
        --   vim.fn.getcompletion("", "compiler")
        --
        -- > Get back all OS user names:
        --   vim.fn.getcompletion("", "user")
        --
        -- Read `:h getcompletion` to know all of theme
        --
        finder = finders.new_table({
            --
            -- Entries
            --
            results = CMD_LIST,
        }),

        --
        -- `sorter` on the other hand is not a required field but it's good
        -- practice to define it, because the default value will set it to
        -- `empty()`, meaning no sorter is attached and you can't filter the
        -- results.
        --
        -- Good practice is to set the sorter to either
        -- `conf.generic_sorter(opts)` or `conf.file_sorter(opts)`.
        --
        sorter = conf.generic_sorter(opts),

        --
        -- Attach key mappings
        --
        -- `@prompt_bufnr` is the buffer number of the prompt buffer, which we
        -- can use to get the pickers object
        --
        -- `@map` is a function we can use to map actions or functions to
        -- arbitrary key sequences.
        --
        attach_mappings = function(prompt_bufnr, _)
            --
            -- Override the `select_default` action (triggered by presisng `<CR>`)
            -- to do something else
            --
            local new_select_default_handler = function()
                -- Close the picker
                actions.close(prompt_bufnr)

                -- Get selected entry
                local selection = action_state.get_selected_entry()

                -- Get trimmed user input
                local user_input = action_state.get_current_line()
                user_input = user_input:match "^%s*(.-)%s*$"

                if (enable_debug_print) then
                    print(">>> [ Project_command > run ] - selection: " .. vim.inspect(selection))
                    print(">>> [ Project_command > run ] - user input: " .. vim.inspect(user_input))
                end

                local command = ""

                --
                -- First time case: CMD_LIST is empty
                --
                if (selection == nil) then
                    if (user_input == "") then
                        print(">>> [ Project_command > run ] - No command to run")
                        return
                    else
                        command = user_input
                        table.insert(CMD_LIST, command)
                    end
                    --
                    -- CMD_LIST is not empty:
                    --
                    -- Prefer `user_input` instead of `selection[1]` if they're
                    -- different!!!
                    --
                else
                    if (user_input ~= "" and selection[1] ~= user_input) then
                        command = user_input
                        table.insert(CMD_LIST, command)
                    else
                        command = selection[1]
                    end
                end

                if (enable_debug_print) then
                    print(">>> [ Project_command > run ] - command: " .. command)
                end

                -- execute_command(command)
                execute_command_v2(command)
            end

            actions.select_default:replace(new_select_default_handler)

            --
            -- `attach_mappings` needs to return `true` if you want to map
            -- default_mappings and `false` if not
            --
            return true
        end,
    })

    --
    -- After the picker is defined you need to call `find()` to actually start
    -- the picker.
    --
    cmd_picker:find();
end

--
-- Run `:luafile %` to test this module
--
-- run()


-- lua vim.api.nvim_buf_call(buf, function() vim.cmd('edit /absolute/path/to/a/file.lua') end)
--
return {
    run = run
}
