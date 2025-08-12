vim.g.python3_host_prog = os.getenv('HOME') .. "/dotfiles/pynvim-venv/bin/python3"

require("config.options")
require("config.keymaps")
require("config.lazy")

-- Lazy loading
require("lazy").setup("plugins", {
    change_detection = {
        notify = false, -- Disable notifications for changes
    },
})
