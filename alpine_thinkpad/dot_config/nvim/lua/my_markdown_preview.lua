if vim.g.enable_vim_debug then print "'my_markdown_preview' has been reloaded >>>" end

--[[
-----------------------------------------------------------------------
markdown_preview setting that only apply to Alpine Linux!!!
-----------------------------------------------------------------------
--]]

local os_info = vim.loop.os_uname()

if (os_info.sysname == "Linux" and string.find(os_info.version, "Alpine") )then
    function open_preview_in_brave(url)
        os.execute('/home/wison/my-shell/start_brave_browser.sh')
        print(">>> my_markdown_preview >>> open_preview_in_brave | url: "..url)
    end

    -- Custom open browser function
    -- vim.cmd 'let g:mkdp_browserfunc = \'/home/wison/my-shell/start_brave_browser.sh\''
    vim.cmd 'let g:mkdp_browserfunc = \'open_preview_in_brave\''
    if vim.g.enable_vim_debug then print "'my_markdown_preview' has been reloaded >>>" end

    print("my_markdown_preview >> Alpine custom browser function setup [ done ]")
end
