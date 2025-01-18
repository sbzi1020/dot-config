-------------------------------------------------------------------------------
-- Show pretty tab bar 
-------------------------------------------------------------------------------
return {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    --
    -- Disabled, as I don't need it
    --
    enabled = false,

    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                mode = "tabs",

                -- `slant` | `padded_slant` | `slope`  | `padded_slope`  | `thick` | `thin`
                separator_style = "thick",
                indicator = {
                    -- 'icon' | 'underline' | 'none',
                    style = 'underline',
                },
            }
        })
    end
}
