return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 500,
        icons = {
            mappings = true,
        },
        spec = {
            { "<leader>f", group = "find" },
            { "<leader>g", group = "git" },
            { "<leader>d", group = "debug" },
            { "<leader>t", group = "test" },
            { "<leader>x", group = "diagnostics" },
            { "<leader>c", group = "code" },
            { "<leader>l", group = "lsp" },
            { "[",         group = "prev" },
            { "]",         group = "next" },
        },
    },
}
