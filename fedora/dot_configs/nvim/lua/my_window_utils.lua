--
-- Close all other windwos and keep the current one
--
local kill_other_windows = function()
    local win_list = vim.api.nvim_list_wins()
    local current_win = vim.api.nvim_get_current_win()
    -- print(" [ kill_other_windows ] - current_win: "..current_win)

    for _, win in ipairs(win_list) do
        -- print(" [ kill_other_windows ] - win: "..win)
        if (win ~= current_win) then
            vim.api.nvim_win_close(win, false)
        end
    end
end

return {
    kill_other_windows = kill_other_windows
}
