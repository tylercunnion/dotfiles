local function sync_system_theme()
	-- Query macOS system appearance
	local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
	local result = handle:read("*a")
	handle:close()

	-- If 'Dark' is returned, set dark; otherwise (nil/Light), set light
	if result:match("Dark") then
		vim.o.background = "dark"
	else
		vim.o.background = "light"
	end
end

-- 1. Run on startup
sync_system_theme()

-- 2. Run whenever Neovim Regains focus
vim.api.nvim_create_autocmd("FocusGained", {
	callback = sync_system_theme,
})
