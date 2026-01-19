return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },
                python = { "black" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                lua = { "stylua" },
                html = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" }
            },
            format_after_save = {
                lsp_fallback = true,
            }
        })
    end
}
