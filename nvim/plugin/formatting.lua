-- Formatting
require("conform").setup({
	formatters_by_ft = {
		go = { "gci", "gofumpt", "golines" },
		python = { "black" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		lua = { "stylua" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
	},
	formatters = {
		gci = {
			args = {
				"write",
				"--section",
				"standard",
				"--section",
				"default",
				"--section",
				"Prefix(github.com/temporalio)",
				"$FILENAME",
			},
		},
		golines = {
			args = { "--max-len=80", "--base-formatter=gofumpt" },
		},
	},
	format_after_save = {
		timeout_ms = 1000,
		lsp_format = "fallback",
	},
})
