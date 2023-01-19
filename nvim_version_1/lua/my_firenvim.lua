if vim.g.enable_vim_debug then print "'my_firenvim' has been reloaded >>>" end

--[[
Here are the key settings to make firenvim works:

1. Open `chrome://extensions/shortcuts` and edit the following settings with
your customized shortcuts (for example: Ctrl+E or Command+E)

`Turn the currently focused element into a neovim iframe.`


2. Open the browser firenvim plugin's json

A> MacOS + Chrome, json file located at

    `~/Library/Application\ Support/Google/Chrome/NativeMessagingHosts/firenvim.json`

B> Linux + Brave Browser, json file located at:

    `~/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts/firenvim.json`


Then make sure it contains the correct path that point to `firenvim` plugin
script:

    ```bash
    # MacOS
    "path": "/Users/wison/.local/share/firenvim/firenvim"

    # Linux
    "path": "/home/wison/.local/share/firenvim/firenvim"
    ```

So, print out that `path` file and make sure the `exec` path points to the
correct path to your `neovim`:

    ```bash
    # MacOS
    exec '/usr/local/Cellar/neovim/0.6.1/bin/nvim' --headless --cmd 'let g:started_by_firenvim = v:true' -c 'call firenvim#run()'

    # Linux
    exec '/usr/bin/nvim'
    ```

4. Also, how firenvim works is that, you open browser, then it will run the
above plugin script, create a temp `var` folder like below and then run `exec`.
So, after you open chrome and open a `<textarea>`, try to `ls -lht` that `var`
folder to see it exists or not. If not exists, that means something wrong or
permission issue. You better create them manually and set the correct permission.

Those `/var` folder commands are list in the top of `path` file, e.g.:

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


-- No need to set explicitly under Neovim: always uses UTF-8 as the default encoding.
-- set encoding=UTF-8
vim.cmd 'set guifont=SauceCodePro_Nerd_Font:h11'



--[[
-----------------------------------------------------------------------
Change `firenvim` file type to enable syntax highlight
-----------------------------------------------------------------------
--]]
local firenvimGroup = vim.api.nvim_create_augroup('FirenvimGroup', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = {
        'github.com_*.txt',
    },
    callback = function()
        vim.bo.filetype = 'markdown'

        -- print out the debug message
        -- local debugMsg = {
        --     fileName = vim.fn.expand('<afile>'),
        --     matchFileType = vim.fn.expand('<amatch>')
        -- }

        -- vim.schedule(function()
        --     print(">>> Already set filetype.")
        --     print("Auto command debug message: "..vim.inspect(debugMsg))
        -- end)
    end,
    group = firenvimGroup
})

-- vim.cmd([[autocmd UIEnter * :call luaeval('OnUIEnter(vim.fn.deepcopy(vim.v.event))')]])
vim.api.nvim_create_autocmd('UIEnter', {
    pattern = '*',
    command = ":call luaeval('OnUIEnter(vim.fn.deepcopy(vim.v.event))')",
    group = firenvimGroup
})

