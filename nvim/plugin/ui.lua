-- Colorscheme
require("solarized").setup({
	palette = "selenized",
	styles = {
		comments = { italic = true },
	},
})
vim.cmd.colorscheme("solarized")

-- UI
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

require("which-key").setup({
	delay = 500,
	icons = { mappings = true },
	spec = {
		{ "<leader>f", group = "find" },
		{ "<leader>g", group = "git" },
		{ "<leader>d", group = "debug" },
		{ "<leader>t", group = "test" },
		{ "<leader>x", group = "diagnostics" },
		{ "<leader>c", group = "code" },
		{ "<leader>l", group = "lsp" },
		{ "[", group = "prev" },
		{ "]", group = "next" },
	},
})

require("bufferline").setup({})
