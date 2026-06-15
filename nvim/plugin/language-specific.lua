if not require("config.profile").full then
	return
end

-- Go tools
require("gopher").setup()

-- Refresh inlay hints after external buffer changes to prevent "col out of range" errors.
-- This fires when Neovim detects the file changed on disk (e.g. formatting by an agent).
vim.api.nvim_create_autocmd({ "FileChangedShellPost", "BufReadPost" }, {
	pattern = "*.rs",
	callback = function(args)
		local bufnr = args.buf
		vim.schedule(function()
			if vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }) then
				vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			end
		end)
	end,
})
