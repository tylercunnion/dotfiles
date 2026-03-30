vim.opt.number        = true
vim.opt.ls            = 2
vim.opt.tabstop       = 4
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.opt.expandtab     = true
vim.opt.termguicolors = true
vim.opt.signcolumn    = "yes"
vim.opt.scrolloff     = 8
vim.opt.cursorline    = true
vim.opt.undofile      = true

vim.diagnostic.config({
    virtual_text = {
        prefix = '●',
        source = "if_many",
    },
    float = {
        border = 'rounded',
        source = true,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
})
