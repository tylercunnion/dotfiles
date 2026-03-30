return { -- LSP config
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
        'saghen/blink.cmp',
    },
    config = function()
        vim.lsp.config('*', {
            capabilities = require('blink.cmp').get_lsp_capabilities(),
            on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, silent = true }

                vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
                vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gh', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
                vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
                vim.keymap.set('n', '<leader>ll', vim.lsp.codelens.run, opts)
                vim.keymap.set('n', '<leader>lR', vim.lsp.buf.rename, opts)

                if client and client.supports_method('textDocument/inlayHint') then
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                end
            end,
        })

        vim.lsp.config('gopls', {
            cmd = { 'gopls' },
            root_markers = { 'go.work', 'go.mod', '.git' },
            settings = {
                gopls = {
                    gofumpt = true,
                    analyses = { unusedparams = true, shadow = true },
                    staticcheck = true,
                    completeUnimported = true,
                    usePlaceholders = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                    },
                },
            },
        })
        vim.lsp.config('golangci_lint_ls', {
            cmd = { 'golangci-lint-langserver' },
            root_markers = { '.golangci.yml', '.golangci.yaml', 'go.mod' },
        })

        vim.lsp.enable('gopls')
        vim.lsp.enable('golangci_lint_ls')
    end
}
