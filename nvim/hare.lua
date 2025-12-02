local M = {
    name = 'hare',
}

--[[
This function could check buffer filetype, existence of required modules, etc.

The config table comes from the user's configuration in the
`providers['provider-name']` table where provider-name is the
`require('outline.providers.<name>').name`.

@param bufnr integer - Current buffer index
@param config table? - User configuration
@return boolean - whether supported or not, returning `false` causes the UI to
                  show `No supported provider...`
        info? - Table that passes into `get_status` function
--]]
function M.supports_buffer(bufnr, config)
    -- local log_prefix = ">>> [ hare provider > supports_buffer ] "
    -- print(log_prefix .. "config: " .. vim.inspect(config))

    local ft = vim.api.nvim_buf_get_option(bufnr, 'ft')
    -- print(">>> [ hare provider > supports_buffer ] ft: ".. ft)

    -- `info` param that passes into `get_status` function
    local status_info = {
        name = "Hare external provider",
        version = "1.0",
    }

    if config and config.filetypes then
        for _, ft_check in ipairs(config.filetypes) do
            if ft_check == ft then
                return true, status_info
            end
        end
    end
    return ft == "hare", status_info
end


--[[
Return a list of lines to be included in `:OutlineStatus` as supplementary
information when this provider is active.

-- param info table? - Must be the table received from `supports_buffer`
--]]
function M.get_status(info)
    -- local log_prefix = ">>> [ hare provider > get_status ] "
    -- print(log_prefix .. "info: " .. vim.inspect(info))

    if not info then
        return { 'No provider info was found.' }
    end
    
    -- Basically, stringify the `info` table
    return {
        "name: "..info.name,
        "version: "..info.version,
    }
end


--[[
This funtion will be called to create UI

-- @param on_symbols - Callabck(symbols?:outline.ProviderSymbol[], opts?:table)
    Each symbol table in the list of symbols should have these fields:

    name: string
    kind: integer
    selectionRange: table with fields start and end, each have fields line and
                    character, each integers
    range: table with fields start and end, each have fields line and character
           , each integers
    children: list of table of symbols
    detail: (optional) string, shown for outline_items.show_symbol_details

-- @param opts - Table that passes into `on_symbols` callback without processing
--]]
function M.request_symbols(on_symbols, opts)
    --
    -- Get back the treesitter parser
    --
    local status, parser = pcall(vim.treesitter.get_parser, 0, 'hare')
    if not status or not parser then
      callback(nil, opts)
      return
    end

    --
    -- Call `parser::parse()` and get back the syntax tree and its root node
    --
    local syntax_tree = parser:parse()
    local root = syntax_tree[1]:root()
    if not root then
        callback(nil, opts)
        return
    end


    local symbol_list = {} -- Symbol list/array
    local symbol_index = 1 -- Symbol list/array index

    local ts = require("vim.treesitter")

    --
    -- Run the query to list types
    --
    local function_query = vim.treesitter.query.parse('hare', [[
        (type_declaration (identifier) @type)
    ]])

    for _, type_node, _ in function_query:iter_matches(root, 0) do
        local type_name_node = type_node[1]
        local type_name = ts.get_node_text(type_name_node, 0)
        local row1, col1, row2, col2 = type_name_node:range()
        -- print(">>> function name: "..function_name)
        -- print(">>> function name node: "..vim.inspect(function_name_node))

        --
        -- Append symbol
        --
        symbol_list[symbol_index] = {
            children = {},
            --
            -- kind -> https://github.com/hedyhli/outline.nvim/blob/main/lua/outline/symbols.lua
            --
            kind = 23,
            name = type_name, -- Use as UI item title
            range = {
                ["end"] = { character = col2, line = row2 },
                start = { character = col1, line = row1 }
            },
            selectionRange = {
                ["end"] = { character = col2, line = row2 },
                start = { character = col1, line = row1 }
            }
        }

        symbol_index = symbol_index + 1
    end

    --
    -- Run the query to list all function names
    --
    local function_query = vim.treesitter.query.parse('hare', [[
        (function_declaration name: (identifier) @function_name)
    ]])

    for _, function_node, _ in function_query:iter_matches(root, 0) do
        local function_name_node = function_node[1]
        local function_name = ts.get_node_text(function_name_node, 0)
        local row1, col1, row2, col2 = function_name_node:range()
        -- print(">>> function name: "..function_name)
        -- print(">>> function name node: "..vim.inspect(function_name_node))

        --
        -- Append symbol
        --
        symbol_list[symbol_index] = {
            children = {},
            --
            -- kind -> https://github.com/hedyhli/outline.nvim/blob/main/lua/outline/symbols.lua
            --
            kind = 12,
            name = function_name, -- Use as UI item title
            range = {
                ["end"] = { character = col2, line = row2 },
                start = { character = col1, line = row1 }
            },
            selectionRange = {
                ["end"] = { character = col2, line = row2 },
                start = { character = col1, line = row1 }
            }
        }

        symbol_index = symbol_index + 1
    end

    on_symbols(symbol_list, opts)
end

return M
