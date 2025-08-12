return {
    'Tsuzat/NeoSolarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('NeoSolarized').setup({
            style = "dark",
            transparent = false,
            enable_italics = true,
            styles = {
                comments = { italic = true },
            },
        })
        vim.cmd [[ colorscheme NeoSolarized ]]
    end
}
