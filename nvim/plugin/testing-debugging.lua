-- Testing
require("neotest").setup({
	adapters = {
		require("neotest-go")({
			experimental = { test_table = true },
			args = { "-count=1", "-timeout=60s" },
		}),
	},
	output = { open_on_run = false },
	summary = { animated = true },
})

vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			return diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
		end,
	},
}, vim.api.nvim_create_namespace("neotest"))

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Run file tests" })
vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run last test" })
vim.keymap.set("n", "<leader>td", function()
	require("neotest").run.run({ strategy = "dap" })
end, { desc = "Debug nearest test" })
vim.keymap.set("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
vim.keymap.set("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Open test output" })
vim.keymap.set("n", "<leader>tO", function()
	require("neotest").output_panel.toggle()
end, { desc = "Toggle output panel" })
vim.keymap.set("n", "<leader>tx", function()
	require("neotest").run.stop()
end, { desc = "Stop test run" })

-- Debugging
local dap = require("dap")
local dapui = require("dapui")

require("dap-go").setup()
dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
vim.keymap.set("n", "<leader>dB", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Conditional breakpoint" })
vim.keymap.set("n", "<F6>", dap.continue, { desc = "Debug: continue" })
vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: step out" })
vim.keymap.set("n", "<F9>", dap.terminate, { desc = "Debug: terminate" })
vim.keymap.set("n", "<leader>dt", require("dap-go").debug_test, { desc = "Debug test" })
vim.keymap.set("n", "<leader>dT", require("dap-go").debug_last_test, { desc = "Debug last test" })
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })
