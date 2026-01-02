if vim.g.enable_vim_debug then print "'my_galaxyline' has been loaded >>>" end

--[[
-----------------------------------------------------------------------
'glepnir/galaxyline.nvim'
-----------------------------------------------------------------------
--]]
local loaded_pack = Reload_package('galaxyline')
-- print(vim.inspect(loaded_pack))
local gls = loaded_pack.section
local condition = Reload_package('galaxyline.condition')

local set_highlight_by_current_mode = function()
    local mode_color = {
        n = 'GalaxyViModeNomral',
        i = 'GalaxyViModeInsert',
        v = 'GalaxyViModeVisual',
        [''] = 'GalaxyViModeVisual',
        V = 'GalaxyViModeVisual',
        c = 'GalaxyViModeCommand',
        no = 'GalaxyViModeOther',
        s = 'GalaxyViModeInsert',
        S = 'GalaxyViModeInsert',
        [''] = 'GalaxyViModeInsert',
        ic = 'GalaxyViModeInsert',
        R = 'GalaxyViModeInsert',
        Rv = 'GalaxyViModeInsert',
        cv = 'GalaxyViModeInsert',
        ce = 'GalaxyViModeInsert',
        r = 'GalaxyViModeInsert',
        rm = 'GalaxyViModeInsert',
        ['r?'] = 'GalaxyViModeOther',
        ['!']  = 'GalaxyViModeOther',
        t = 'GalaxyViModeOther',
    }
    return mode_color[vim.fn.mode()]
end

-- Left: Vim mode
gls.left[1] = {
    ViMode = {
        provider = function()
            local mode_descs = {
                n = ' NORMAL ',
                i = ' INSERT ',
                c= ' COMMAND ',
                v= ' VISUAL ',
                V= ' VISUAL-LINE ',
                R= ' REPLACE ',
                s= ' REPLACE ',
		        s= 'Select by character',
		        S= 'Select by line',
                [''] = ' VISUAL-BLOCK ',
            }

            vim.api.nvim_command('highlight! link GalaxyViMode ' .. set_highlight_by_current_mode())

            return ' ' .. mode_descs[vim.fn.mode()]
        end,
        separator = ' ',
    },
}

-- Left: Spell checking
gls.left[2] = {
    SpellChecking = {
        provider = function()
            if vim.wo.spell == true then return ' ⏻ SPELL ' else return '' end
        end,
        separator = ' ',
        highlight = 'GalaxySpellChecking', -- Customized highlight group in color scheme
    }
}

-- Left: Git branch
local current_git_branch = require('galaxyline.provider_vcs').get_git_branch()

gls.left[3] = {
    ShowGitBranch = {
        --provider = 'GitBranch',
        provider = function()
           return '[ ' .. current_git_branch .. ' ]'
        end,
        -- condition = condition.check_git_workspace,
        condition = function()
            local function is_empty()
                return current_git_branch ~= nil
            end
            return condition.check_git_workspace() and condition.hide_in_width() and is_empty()
        end,
        separator = ' ',
        highlight = 'GalaxyShowGitBranch', -- Customized highlight group in color scheme
    }
}

-- Left: File name
gls.left[4] = {
    FileName = {
        provider = function() return vim.fn.expand('%')
        end,
        condition = condition.buffer_not_empty,
        separator = ' ',
        highlight = 'GalaxyFileName', -- Customized highlight group in color scheme
    }
}

-- Left: Diagnostic error
gls.left[6] = {
    DiagnosticError = {
        provider = 'DiagnosticError',
        icon = '  ',
        separator = ' ',
        highlight = 'GalaxyDiagnosticError', -- Customized highlight group in color scheme
    }
}

-- Left: Diagnostic warning
gls.left[7] = {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn',
        icon = ' ',
        separator = ' ',
        highlight = 'GalaxyDiagnosticWarn', -- Customized highlight group in color scheme
    }
}

-- Left: Diagnostic hint
gls.left[8] = {
    DiagnosticHint = {
        provider = 'DiagnosticHint',
        icon = ' ',
        separator = ' ',
        highlight = 'GalaxyDiagnosticHint', -- Customized highlight group in color scheme
    }
}

-- Left: Diagnostic info
gls.left[9] = {
    DiagnosticInfo = {
        provider = 'DiagnosticInfo',
        icon = ' ',
        separator = ' ',
        highlight = 'GalaxyDiagnosticInfo', -- Customized highlight group in color scheme
    }
}

-- Rright: File type
gls.right[1] ={
    FileType = {
        provider = function()
            -- File type, Make the first character upper case
            return vim.bo.filetype:gsub("^%l", string.upper)
        end,
        condition = condition.buffer_not_empty,
        separator = ' ',
        highlight = 'GalaxyFileType', -- Customized highlight group in color scheme
    },
}

-- Right: File encode
gls.right[2] = {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = 'GalaxyFileEncodeSeparator',
        highlight = 'GalaxyFileEncode', -- Customized highlight group in color scheme
    }
}

-- Right: Line percentage
gls.right[3] = {
    LinePercent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = 'GalaxyLinePercentSeparator',
        highlight = 'GalaxyLinePercent', -- Customized highlight group in color scheme
    }
}

-- Right: Line info
gls.right[4] = {
    LineInfo = {
        provider = function()
            return 'L:' .. vim.fn.line(".") .. '/' .. vim.fn.line("$")
        end,
        separator = ' ',
        separator_highlight = 'GalazyLineInfoSeparator',
        highlight = 'GalaxyLineInfo',
    }
}

-- Right: Line column
gls.right[5] = {
    LineColumn = {
        provider = function() return 'C:' .. vim.fn.col('.') end,
        separator = ' ',
        separator_highlight = 'GalazyLineColumnSeparator',
        highlight = 'GalaxyLineColumn',
    },
}

