return {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            -- Enable treesitter check
            check_ts = true,
            ts_config = {
                lua = {'string'},-- it will not add a pair on that treesitter node
                javascript = {'template_string'},
                java = false,-- don't check treesitter on java
            }
        })

        --
        -- Work with `nvim-cmp`: add autopair when you choose a function in
        -- completion list
        --
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
            'confirm_done',
            cmp_autopairs.on_confirm_done()
        )
    end
}
