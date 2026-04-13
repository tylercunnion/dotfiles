vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then
				vim.cmd.packadd("nvim-treesitter")
			end
			vim.cmd("TSUpdate")
		end
		if name == "gopher.nvim" and (kind == "install" or kind == "update") then
			if not ev.data.active then
				vim.cmd.packadd("gopher.nvim")
			end
			vim.cmd("silent! GoInstallDeps")
		end
		if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
			local dir = ev.data.spec.dir
			vim.system({ "make" }, { cwd = dir })
		end
	end,
})

vim.api.nvim_create_user_command("PackUpdate", function()
	vim.pack.update()
end, {})

vim.pack.add({
	-- Shared dependencies
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-neotest/nvim-nio",

	-- UI
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/maxmx03/solarized.nvim",
	"https://github.com/nvim-lualine/lualine.nvim",
	"https://github.com/folke/which-key.nvim",
	"https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/akinsho/bufferline.nvim",

	-- Treesitter
	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/nvim-treesitter/nvim-treesitter-context",

	-- LSP / completion
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/zbirenbaum/copilot.lua",
	"https://github.com/fang2hou/blink-copilot",
	{ src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.x") },
	"https://github.com/milanglacier/minuet-ai.nvim",
	"https://github.com/folke/lazydev.nvim",

	-- Formatting
	"https://github.com/stevearc/conform.nvim",

	-- Git
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/sindrets/diffview.nvim",
	"https://github.com/NeogitOrg/neogit",

	-- Navigation
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",

	-- Testing
	"https://github.com/nvim-neotest/neotest",
	"https://github.com/nvim-neotest/neotest-go",

	-- Debugging
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/leoluz/nvim-dap-go",
	"https://github.com/rcarriga/nvim-dap-ui",

	-- Go tools
	"https://github.com/olexsmir/gopher.nvim",

	-- Editing
	"https://github.com/nvim-mini/mini.nvim",

	-- Misc
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/Cannon07/claude-preview.nvim",
})
