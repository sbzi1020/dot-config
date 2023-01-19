# `init.lua` configuration guide

#### How to define a `module/object` in `Lua`
-----------------------------------------------------------------------

In `Lua`, there is a `Table` type which works like a `JSON` in `JavaScript`.
It represents a dynamically allocated object and access via `key`. The `key`
can be any type in `Lua`:

```lua
-- Define a empty table
local my_module = {}

-- Add value to the table via different type of the key
my_module[0] = 123
my_module.private_field_here = 456
my_module["any_string_key_here"] = "Any string value here"

-- Get back the value via key
print(my_module[0])
print(my_module.private_field_here)
print(my_module["any_string_key_here"])
print(my_module["should_get_nil_for_this_case"])
```

</br>

The `M.x` is same the `M[x]`, but you only can use the same way to assign and access. 
For example:

```Lua
local M = {}
M.a = "A value"
print(M.a)      -- Should print "A value"
print(M[a])     -- Should print `nil`
```

</br>

When assigning value to table's field, use `=` instead of `:`

```lua
local M = {
    name = "Wison Ye",
    show_name = function()
    end
}
```

</br>

Here is composited table case, it works like a complicated JSON:

```lua
local M1 = {}
M1.a = "A"
M1.b = "B"

local M2 = {}
M2.another_module = M1
M2.name = "It's a composited object"

print(vim.inspect(M2))
```

</br>

Here is the `JSON-liked` sample:

```lua
local M1 = {}
M1.name = "Module name: M1"
M1.setup = function()
    print "M1's setup method"
end

print(vim.inspect(M1))
M1.setup()
```

</br>

How to go through the table? Use `pairs()`:

```lua
local M1 = {}
M1.name = "Module name: M1"
M1.setup = function()
    print "M1's setup method"
end

for key, value in pairs(M1) do 
    print("key: ", key, ", value: ", value)
end
```

</br>

How to define a module which you can export as a `Vim plugin`:

```lua
local vim_plugin_module = {}

vim_plugin_module.FUNTION_NAME_HERE = function ()
-- ... ignore the implementation
end

-- Ingnore another functions

-- Finlay return the module itself
return vim_plugin_module
```

</br>

#### How `require` works in `Lua` and how to reload package
-----------------------------------------------------------------------

```lua
require('my_package')
```

The `Lua` command above is talking: Plz look for `my_package.lua` or 
`my_package/init.lua` in the `packge.path`. If found, then use 
`package.loaders` to load it into the memory.

If you want to print out the `package.path` to see what path inside there,
you can run the command below in `neovim`:

```lua
:lua print(package.path)
```

Here is my print result (after separated by `;`):

```
.lua;
/Users/runner/work/neovim/neovim/.deps/usr/share/luajit-2.1.0-beta3/?.lua;
/usr/local/share/lua/5.1/?.lua;
/usr/local/share/lua/5.1/?/init.lua;
/Users/runner/work/neovim/neovim/.deps/usr/share/lua/5.1/?.lua;
/Users/runner/work/neovim/neovim/.deps/usr/share/lua/5.1/?/init.lua
```

</br>

- So what happen if I call the same `require('my_package')` for many times?

    For example if you have the `print` statement below in your `my_package.lua`:

    ```
    print "'my_package' has been loaded >>>>"
    ```

    Then require it for many times like below:

    ```lua
    require('my_package')
    require('my_package')
    require('my_package')
    ```

    The result is that it only print once. That means the `require` (or `package.loaders`)
    works like the `Node.JS's require`: Only loads once into the memory!

</br>

- The next question would be `How to reload package dynamically?`

    Here is the key:

    ```lua
    package.loaded['my_package'] = nil
    ```

    The next time to `require 'my_package'`, it will load that again! Try this:

    ```lua
    require('my_package')
    package.loaded['my_package'] = nil

    require('my_package')
    package.loaded['my_package'] = nil

    require('my_package')
    package.loaded['my_package'] = nil
    ```

    And you should see print 3 times!!!

    </br>

#### You don't need to load `vim` module manually
-----------------------------------------------------------------------

`vim` module will be loaded automatic, that's why you don't need to do
the following command manually:

```lua
require('vim')
```

</br>

#### Default settings
-----------------------------------------------------------------------

`Neovim` already enabled many options by default. For more details, plz access
[here](https://neovim.io/doc/user/vim_diff.html)

</br>

#### Calling `VimScript` in `Lua`

- Run `VimScript` command in `Lua`

    ```lua
    -- This is the standard API to run a VimScript command:
    vim.api.nvim_command('COMMAND_HERE')

    -- This is the short version for calling `vim.api.nvim_command`:
    vim.cmd('COMMAND_HERE')

    -- In `Lua`, you dont' need the `()` to call a function if that function has
    -- only one paramter
    vim.cmd 'COMMAND_HERE'
    ```

    </br>

- Call `Vim function` in `Lua`

    ```lua
    vim.fn.VIM_FUNCTION_NAME_CALL

    -- Check whether exists or not
    local exists_complete_info = vim.fn.exists('*complete_info')

    -- Get back shell env var
    USER = vim.fn.expand('$USER')

    -- Do different settings for the particular platform
    if vim.fn.has("mac") == 1 then
        -- Do something foucs on Mac shell environment
    elseif vim.fn.has("unix") == 1 then
        -- Do something foucs on Linux shell environment
    else
        -- Do something else foucs on another platform
    end

    -- Call vim function like this
    vim.fn['compe#complete']()
    vim.fn['mkdp#util#install']
    vim.fn.call("vsnip#jumpable", {-1})

    -- Check whether the popup menu shows
    if vim.fn.pumvisible() == 1 then XXXX end

    -- Check whether executable (binary) exists or not
    if vim.fn.executable('rg') == 1 then XXXX end
    ```

</br>

#### Calling `Lua` in `VimScript`

Using `v:lua.LUA_COMMAND_OR_FUNCTION_CALL_HERE`

```vimscript
:echo v:lua.vim.fn.sin(1)
:call v:lua.vim.fn.sin(1)

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
```

</br>

#### How to run `Lua` command in `vim command mode`?

```lua
:lua LUA_COMMAND_HERE
```

</br>

#### How to reload `Lua` file?

```lua
-- Reload the current file. All loaded package via `require` won't
-- be reload again!!!
:luafile %

--- Reload the particular Lua file
:luafile LUA_FILE_NAME_HERE
```

</br>

#### How to print value in `Lua`?

```lua
-- Print string
print("keybinding.lua has been loaded >>>")

-- Print object or composite type
-- print(vim.inspect(XXX))
print(vim.inspect(vim.api))
```

Any `print()` result and `echo ""` result is called `messages` which you
can access the history by running `:messages`

</br>

#### How to bind a key to run `Lua` command rather than `vimscript`?

```lua
-- mode - string value below:
-- String value            Help page   Affected modes                              Vimscript equivalent
-- '' (an empty string)	mapmode-nvo Normal, Visual, Select, Operator-pending       :map
-- 'n'                     mapmode-n   Normal                                      :nmap
-- 'v'                     mapmode-v   Visual and Select                           :vmap
-- 's'                     mapmode-s   Select                                      :smap
-- 'x'                     mapmode-x   Visual                                      :xmap
-- 'o'                     mapmode-o   Operator-pending                            :omap
-- '!'                     mapmode-ic  Insert and Command-line                     :map!
-- 'i'                     mapmode-i   Insert                                      :imap
-- 'l'                     mapmode-l   Insert, Command-line, Lang-Arg              :lmap
-- 'c'                     mapmode-c   Command-line                                :cmap
-- 't'                     mapmode-t   Terminal                                    :tmap
vim.api.nvim_set_keymap('mode', 'key-to-bind', ':lua LUA_COMMAND_OR_FUNCTION_CALL_HERE<CR>', option)

-- For example:
vim.api.nvim_set_keymap('n', '<leader>pr', ':lua print(">>>")<CR>', {noremap=true, silent=true})

vim.api.nvim_set_keymap('n', '<leader>rr', ':luafile ~/.config/nvim/init.lua<CR>:setlocal nospell<CR>', {noremap=true})

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
```

</br>

#### How to log command output into a split unnamed buffer
```lua
-- `redir @"`: Start to redirect all messages to register `"` until the `redir END` be called
-- `redir END`: End the redirect behaviour
-- `vs`: Do a vertical split, cursor moves to the new split window
-- `enew`: Edit a new unnamed buffer
-- `pu/lineput`: Put the text (from the register) to current buffer after current line.
--               For more details about "from which register", plz access `:h pu`
vim.cmd([[
    redir @"
    echo ">>>>>>>>>>>>>>"
    echo ">>>>>>>>>>>>>>2"
    redir END
    vs|enew|put
]])
```

</br>

#### Plugin auto install

Run `vc` to open `~/.config/nvim/init.lua`, it will install the `paq-nvim` package management tool and 
all plugins automatic. But because it runs in the asynchronous, so it will print out the error below:

```bash
"module XXXXX not found"
```

When pressing enter, message goes away and the async installation will continue. But you still need to 
restart again. After restart `nvim`, you need to run `:PaqInstal` again to make sure all the plulgins
have been installed!!!


