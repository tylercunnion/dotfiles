return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "leoluz/nvim-dap-go",
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")

        require("dap-go").setup()
        dapui.setup()

        -- Open/close UI automatically with debug sessions
        dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

        -- Breakpoints
        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
        vim.keymap.set("n", "<leader>dB", function()
            dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end, { desc = "Conditional breakpoint" })

        -- Control
        vim.keymap.set("n", "<F6>",  dap.continue,      { desc = "Debug: continue" })
        vim.keymap.set("n", "<F10>", dap.step_over,     { desc = "Debug: step over" })
        vim.keymap.set("n", "<F11>", dap.step_into,     { desc = "Debug: step into" })
        vim.keymap.set("n", "<F12>", dap.step_out,      { desc = "Debug: step out" })
        vim.keymap.set("n", "<F9>",  dap.terminate,     { desc = "Debug: terminate" })

        -- Go-specific: debug test under cursor or nearest test function
        vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test,     { desc = "Debug test" })
        vim.keymap.set("n", "<leader>dT", require("dap-go").debug_last_test, { desc = "Debug last test" })

        -- UI toggle
        vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
    end,
}
