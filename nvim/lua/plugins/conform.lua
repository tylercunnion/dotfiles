return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                go = { "goimports", "gofumpt" }
            },
            format_after_save = {
                lsp_fallback = true,
            }
        })
    end
}
