return {
    "nvim-mini/mini.nvim",
    event = "InsertEnter",
    config = function()
        require("mini.pairs").setup({
            mappings = {
                ["("] = { action = "open",  pair = "()", neigh_pattern = "[^\\]." },
                ["["] = { action = "open",  pair = "[]", neigh_pattern = "[^\\]." },
                ["{"] = { action = "open",  pair = "{}", neigh_pattern = "[^\\]." },
                [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
                ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
                ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
                ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^\\].", register = { cr = false } },
                ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
                ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^\\].", register = { cr = false } },
            },
        })
    end,
}
