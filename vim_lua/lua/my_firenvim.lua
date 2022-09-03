if vim.g.enable_vim_debug then print "'my_firenvim' has been reloaded >>>" end

--[[
Here are the key settings to make firenvim works:

1. Open the browser firenvim plugin's json, (Chrome example):

`~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/firenvim.json`

and then make sure it contains the correct path that point to `firenvim` plugin
script:

    ```bash
    # "path": "/Users/wison/.local/share/firenvim/firenvim"
    ```

2. Now, open that plugin script in "path" (/Users/wison/.local/share/firenvim/firenvim).
Then, make sure the `exec` path points to the correct path to your `neovim`:

    ```bash
    # exec '/usr/local/Cellar/neovim/0.6.1/bin/nvim' --headless --cmd 'let g:started_by_firenvim = v:true' -c 'call firenvim#run()'
    ```

3. Also, how firenvim works is that, you open browser, then it will run the
above plugin script, create a temp `var` folder like below and then run `exec`.
So, after you open chrome and open a `<textarea>`, try to `ls -lht` that `var`
folder to see it exists or not. If not exists, that means something wrong or
permission issue:

    ```bash
    mkdir -p /var/folders/xt/8h98vz814978v0ps1w8w0vl40000gn/T//firenvim
    chmod 700 /var/folders/xt/8h98vz814978v0ps1w8w0vl40000gn/T//firenvim
    cd /var/folders/xt/8h98vz814978v0ps1w8w0vl40000gn/T//firenvim
    ```
--]]



--[[
Configuration
--]]
vim.cmd 'let g:firenvim_config = { "globalSettings": { "alt": "all", }, "localSettings": { ".*": { "cmdline": "neovim", "content": "text", "priority": 0, "selector": "textarea", "takeover": "never", }, } }'


--[[
Sample to show how to disable `firenvim` for the particular webiste.

But I don't need that anymore, as already changed the `takeover` to `never`.
That means `firenvim` never show up automatic, I need to press `<CMD + e>` to
active `firenvim` manually which is the way I prefer:)
--]]

-- vim.cmd 'let fc = g:firenvim_config["localSettings"]'
-- vim.cmd 'let fc["https?://twitter.com/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://twitter.tv/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://translate.google.com/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://translate.google.co.nz/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://mail.google.com/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://www.spark.co.nz/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://www.audible.com.au/"] = { "takeover": "never", "priority": 1 }'
-- vim.cmd 'let fc["https?://www.w3schools.com/"] = { "takeover": "never", "priority": 1 }'



-- Change `firenvim` file type to enable syntax highlight
vim.cmd 'autocmd BufEnter github.com_*.txt set filetype=markdown'
vim.cmd 'autocmd BufEnter txti.es_*.txt set filetype=typescript'


-- Increase the font size to solve the `text too small` issue
function IsFirenvimActive(event)
    if vim.g.enable_vim_debug then print("IsFirenvimActive, event: ", vim.inspect(event)) end

    if vim.fn.exists('*nvim_get_chan_info') == 0 then return 0 end

    local ui = vim.api.nvim_get_chan_info(event.chan)
    if vim.g.enable_vim_debug then print("IsFirenvimActive, ui: ", vim.inspect(ui)) end

    --[[
    If this function is running in browser, the `ui` looks like below:
    {
        client = {
            attributes = {
                [true] = 6 -- The channel number
            },
            methods = {
                [true] = 6 -- The channel number
            },
            name = "Firenvim",
            type = "ui",
            version = {
                -- ignore more info here
            }
        },
        id = 5, --
        mode = "rpc",
        stream = "socket
    }

    Otherwise, it looks like this:
    {
        [true] = 6 -- The channel name
    }
    --]]
    local is_firenvim_active_in_browser = (ui['client'] ~= nil and ui['client']['name'] ~= nil)
    if vim.g.enable_vim_debug then print("is_firenvim_active_in_browser: ", is_firenvim_active_in_browser) end
    return is_firenvim_active_in_browser
end

function OnUIEnter(event)
    if IsFirenvimActive(event) then
        -- Disable the status bar
        -- vim.cmd 'set laststatus=0'

        -- Increase the default lines
        -- vim.cmd 'set lines=25'

        -- Increase the font size
        vim.cmd 'set guifont=SauceCodePro_Nerd_Font:h25'
    end
end

vim.cmd([[autocmd UIEnter * :call luaeval('OnUIEnter(vim.fn.deepcopy(vim.v.event))')]])

-- No need to set explicitly under Neovim: always uses UTF-8 as the default encoding.
-- set encoding=UTF-8
vim.cmd 'set guifont=SauceCodePro_Nerd_Font:h11'
