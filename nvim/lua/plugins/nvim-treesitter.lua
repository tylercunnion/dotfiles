return { -- Treesitter for syntax highlighting
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require("nvim-treesitter")
        ts.install { "c", "lua", "vim", "python", "java", "go", "javascript", "typescript" }

        vim.api.nvim_create_autocmd('FileType', {
            pattern = { 'c', 'lua', 'vim', 'python', 'java', 'go', 'javascript', 'typescript' },
            callback = function() vim.treesitter.start() end,
        })
    end
}
