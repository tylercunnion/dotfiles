return {
    "mason-org/mason.nvim",
    config = function()
        require('mason').setup({
            pip = {
                upgrade_pip = true,
                install_args = { "--no-cache-dir" }
            }
        })
    end
}
