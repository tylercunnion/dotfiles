if not require("config.profile").full then return end

-- Treesitter
require("nvim-treesitter").install({ "c", "lua", "vim", "python", "java", "go", "javascript", "typescript" })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "lua", "vim", "python", "java", "go", "javascript", "typescript" },
	callback = function()
		vim.treesitter.start()
	end,
})

require("treesitter-context").setup({
	enable = true,
	max_lines = 3,
	min_window_height = 0,
	line_numbers = true,
	multiline_threshold = 20,
	trim_scope = "outer",
	mode = "cursor",
	separator = nil,
	zindex = 20,
	on_attach = nil,
})
