-- Github Copilot
return {
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
}
