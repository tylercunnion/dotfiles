vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("set number")
vim.cmd("set ls=2")
vim.cmd("set tabstop=4 softtabstop=4 shiftwidth=4 expandtab")

vim.keymap.set('n', '<F5>', ':NvimTreeToggle<CR>')

-- Lazy loading
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { 'williamboman/mason.nvim',
        lazy = false,
        config = true
    },
    { 'williamboman/mason-lspconfig.nvim',
        lazy = false,
        config = true,
        dependencies = {
            'williamboman/mason.nvim',
        }
    },
    { 'nvim-tree/nvim-web-devicons', lazy = false, }, -- Icons for nvim-tree
    { -- Solarized theme
        'Tsuzat/NeoSolarized.nvim',
        lazy = false,
    },
    { -- Treesitter for syntax highlighting
        'nvim-treesitter/nvim-treesitter', -- Treesitter for syntax highlighting
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {"c", "lua", "vim", "python", "java", "go"},
                auto_install = true,
                highlight = { enable = true, },
                indent = { enable = true, },
            })
        end
    },
    { -- Github Copilot
        'zbirenbaum/copilot.lua',
        lazy = true,
        event = "InsertEnter",
        config = function()
            require('copilot').setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
                server_opts_overrides = {
                    settings = {
                        advanced = {
                            listCount = 10, -- #completions for panel
                        }
                    }
                },
            })
        end,
    },
    {
        'zbirenbaum/copilot-cmp', -- Github Copilot source for nvim-cmp
        config = true,
    },
    {
        'hrsh7th/nvim-cmp',   -- Autocompletion
        dependencies = {
            'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
            'hrsh7th/cmp-path', -- Path source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp-signature-help', -- LSP source for signature completion
            'hrsh7th/vim-vsnip', -- vsnip 
            'hrsh7th/cmp-vsnip', -- vsnip source
            'zbirenbaum/copilot-cmp', -- Github Copilot source for nvim-cmp
            'onsails/lspkind-nvim', -- LSP icons for nvim-cmp
        },
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            local select_opts = {behavior = cmp.SelectBehavior.Select}

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
                    {name = 'nvim_lsp_signature_help' },
                    {name = 'copilot'},
                    {name = 'path'},
                    {name = 'nvim_lsp'},
                    {name = 'vsnip' },
                    {name = 'buffer'},
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
                    ['<C-y>'] = cmp.mapping.confirm({select = true}),
                    ['<CR>'] = cmp.mapping.confirm({select = false}),
                }
            })
        end
    },
    {
        'nvim-lualine/lualine.nvim', -- Statusline
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'NeoSolarized',
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', 'diagnostics'},
                    lualine_c = {'filename'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'},
                },
            })
        end
    },
    {
        'nvim-tree/nvim-tree.lua', -- File explorer
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = true,
    },
    { -- LSP config
        'neovim/nvim-lspconfig',
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
            'hrsh7th/cmp-nvim-lsp',
            'folke/neodev.nvim',
        },
        config = function ()
            require('neodev').setup()
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup({ capabilities = lsp_capabilities })
                end
            }
            -- lspconfig.groovyls.setup({
            --    cmd = { 'java', '-jar', '/Users/tycunn/groovy-language-server/build/libs/groovy-language-server-all.jar' },
        end
    }
})

require('NeoSolarized').setup({
    style = "dark",
    transparent = false,
    enable_italics = true,
    styles = {
        comments = { italic = true },
    },
})
vim.cmd [[ colorscheme NeoSolarized ]]

