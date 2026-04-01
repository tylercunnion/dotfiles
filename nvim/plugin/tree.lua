vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
require("nvim-tree").setup({})
vim.keymap.set("n", "<F5>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
