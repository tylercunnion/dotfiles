return { -- LSP config
    'neovim/nvim-lspconfig',
    dependencies = {
        'mason-org/mason-lspconfig.nvim',
        'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
        local on_attach = function(client, bufnr)
            local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

            local opts = { noremap = true, silent = true }

            buf_set_keymap('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
            buf_set_keymap('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
            buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
            buf_set_keymap('n', 'gh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
            buf_set_keymap('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
            buf_set_keymap('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
            buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
            buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
            buf_set_keymap('n', '<leader>ll', '<cmd>lua vim.lsp.codelens.run()<cr>', opts)
            buf_set_keymap('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
            client.server_capabilities.document_formatting = true
        end

        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        vim.lsp.config('*', {
            on_attach = on_attach,
            capabilities = lsp_capabilities,
        })
        vim.lsp.config('gopls', {
            on_attach = on_attach,
            capabilities = lsp_capabilities,
            settings = {
                gopls = {
                    completeUnimported = true,
                    usePlaceholders = true,
                },
            },
        })
    end
}
