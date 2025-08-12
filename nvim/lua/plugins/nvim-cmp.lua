return {
    'hrsh7th/nvim-cmp',                        -- Autocompletion
    dependencies = {
        'hrsh7th/cmp-buffer',                  -- Buffer source for nvim-cmp
        'hrsh7th/cmp-path',                    -- Path source for nvim-cmp
        'hrsh7th/cmp-nvim-lsp',                -- LSP source for nvim-cmp
        'hrsh7th/cmp-nvim-lsp-signature-help', -- LSP source for signature completion
        'hrsh7th/vim-vsnip',                   -- vsnip
        'hrsh7th/cmp-vsnip',                   -- vsnip source
        'zbirenbaum/copilot-cmp',              -- Github Copilot source for nvim-cmp
        'onsails/lspkind-nvim',                -- LSP icons for nvim-cmp
    },
    config = function()
        local cmp = require('cmp')
        local lspkind = require('lspkind')
        local select_opts = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = lspkind.cmp_format({
                    mode = 'symbol',
                    maxwidth = 50,
                    symbol_map = { Copilot = "" },
                    ellipsis_char = '...',
                    show_labelDetails = true,
                })
            },
            sources = {
                { name = 'nvim_lsp_signature_help' },
                { name = 'copilot' },
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'vsnip' },
                { name = 'buffer' },
            },
            mapping = {
                ['<C-Space>'] = cmp.mapping.complete(),

                ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
                ['<Down>'] = cmp.mapping.select_next_item(select_opts),

                ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
                ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),

                ['<C-e>'] = cmp.mapping.abort(),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ['<CR>'] = cmp.mapping.confirm({ select = false }),
            }
        })
    end
}
