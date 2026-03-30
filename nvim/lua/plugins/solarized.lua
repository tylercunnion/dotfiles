return {
    "maxmx03/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require('solarized').setup({
            palette = 'selenized',
            styles = {
                comments = { italic = true }
            },
        })
        --vim.cmd.colorscheme 'solarized'
    end
}
