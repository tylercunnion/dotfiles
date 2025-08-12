return { -- Treesitter for syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = { "c", "lua", "vim", "python", "java", "go" },
            auto_install = true,
            highlight = { enable = true, },
            indent = { enable = true, },
        })
    end
}
