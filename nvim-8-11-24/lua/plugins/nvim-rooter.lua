return {
    "notjedi/nvim-rooter.lua",
    enabled = true,
    config = function()
        require('nvim-rooter').setup({
            rooter_patterns = {
                '.git',
                'build.zig',
                'CMakeLists.txt',
                'configure.sh',
                'run.sh',
            },
            trigger_patterns = {
                '*.c',
                '*.zig',
                '*.ha',
                '*.js',
                '*.ts',
                '*.rs',
            },
            manual = false,
            fallback_to_parent = false,
        })
    end
}
