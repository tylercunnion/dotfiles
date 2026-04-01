vim.g.python3_host_prog = os.getenv("HOME") .. "/dotfiles/pynvim-venv/bin/python3"

require("config.options")
require("config.keymaps")
require("config.theme")
