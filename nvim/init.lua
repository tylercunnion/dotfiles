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
    { -- Treesitter for syntax highlighting
        'nvim-treesitter/nvim-treesitter', -- Treesitter for syntax highlighting
        build = ":TSUpdate",
        config = function ()
            require('nvim-treesitter.configs').setup({
                ensure_installed = {"lua", "vim", "python", "java", "go"},
                highlight = { enable = true, },
                indent = { enable = true, },
            })
        end,
    }, 
    { -- Solarized theme
        'Tsuzat/NeoSolarized.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            require('NeoSolarized').setup({
                style = "dark",
                transparent = false,
            })
            vim.cmd [[ colorscheme NeoSolarized ]]
        end
    }, 
    { -- Github Copilot
        'zbirenbaum/copilot.lua',
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
        dependencies = { 'zbirenbaum/copilot.lua' },
        config = function()
            require('copilot_cmp').setup()
        end
    },
    {
        'hrsh7th/nvim-cmp',   -- Autocompletion
        dependencies = {
            'hrsh7th/cmp-buffer', -- Buffer source for nvim-cmp
            'hrsh7th/cmp-path', -- Path source for nvim-cmp
            'hrsh7th/cmp-nvim-lsp', -- LSP source for nvim-cmp
            'zbirenbaum/copilot-cmp', -- Github Copilot source for nvim-cmp
        },
        config = function()
            local cmp = require('cmp')

            local select_opts = {behavior = cmp.SelectBehavior.Select}

            cmp.setup({
                window = {
                    completion = {
                        border = 'rounded',
                        scrollbar = '║',
                    },
                    documentation = cmp.config.window.bordered(),
                },

                sources = {
                    {name = 'copilot'},
                    {name = 'path'},
                    {name = 'nvim_lsp'},
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
        config = function()
            require('nvim-tree').setup({
            })
        end
    },
    { -- LSP config
        'neovim/nvim-lspconfig',
        dependencies = { 'hrsh7th/cmp-nvim-lsp' },
        config = function ()
            local lspconfig = require('lspconfig')
            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            lspconfig.pyright.setup({
                capabilities = lsp_capabilities
            })
        end
    }
})
