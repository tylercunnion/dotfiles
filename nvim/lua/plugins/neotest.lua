return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    ft = "go",
    keys = {
        { "<leader>tt", function() require("neotest").run.run() end,                        desc = "Run nearest test" },
        { "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end,      desc = "Run file tests" },
        { "<leader>tl", function() require("neotest").run.run_last() end,                   desc = "Run last test" },
        { "<leader>td", function() require("neotest").run.run({ strategy = "dap" }) end,    desc = "Debug nearest test" },
        { "<leader>ts", function() require("neotest").summary.toggle() end,                 desc = "Toggle test summary" },
        { "<leader>to", function() require("neotest").output.open({ enter = true }) end,    desc = "Open test output" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end,            desc = "Toggle output panel" },
        { "<leader>tx", function() require("neotest").run.stop() end,                       desc = "Stop test run" },
    },
    config = function()
        -- Prevent neotest-go and treesitter from clashing on namespace
        local neotest_ns = vim.api.nvim_create_namespace("neotest")
        vim.diagnostic.config({
            virtual_text = {
                format = function(diagnostic)
                    local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
                    return message
                end,
            },
        }, neotest_ns)
        require("neotest").setup({
            adapters = {
                require("neotest-go")({
                    experimental = {
                        test_table = true,
                    },
                    args = { "-count=1", "-timeout=60s" },
                }),
            },
            output = {
                open_on_run = false,
            },
            summary = {
                animated = true,
            },
        })
    end,
}
