return {
    'nvim-tree/nvim-tree.lua',     -- File explorer
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local nvimtree = require("nvim-tree")

        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        nvimtree.setup({
        })
    end,
    keys = {
        {
            '<F5>',
            ":NvimTreeToggle<CR>",
            mode = { "n" },     -- Normal mode
            desc = "Toggle file explorer",
        },
    },
}
