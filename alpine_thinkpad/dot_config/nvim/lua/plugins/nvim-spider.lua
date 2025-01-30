-------------------------------------------------------------------------------
-- Improve `w,e,b` jumpping
-------------------------------------------------------------------------------
return {
    "chrisgrieser/nvim-spider",

    --
    -- This plugin works very well, but it has a bug, `yw` and `dw` don't work
    -- as I expected!!! That's why I disabled it at the moment.
    --
    enabled = false,

    config = function()
        require('spider').setup({
            skipInsignificantPunctuation = true,
            --
            -- Should fixe `dw` and `yw` include the `\r` or '\n', but
            -- it doesn't!!!! 
            --
	        consistentOperatorPending = true,
        })

        vim.keymap.set(
            { "n", "o", "x" },
            "w",
            "<cmd>lua require('spider').motion('w')<CR>",
            { desc = "Spider-w" }
        )
        vim.keymap.set(
            { "n", "o", "x" },
            "e",
            "<cmd>lua require('spider').motion('e')<CR>",
            { desc = "Spider-e" }
        )
        vim.keymap.set(
            { "n", "o", "x" },
            "b",
            "<cmd>lua require('spider').motion('b')<CR>",
            { desc = "Spider-b" }
        )
        --
        -- Fix `cw` issue
        --
        vim.keymap.set("n", "cw", "ce", { remap = true })
    end
}
