return {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
        { "<leader>gD", "<cmd>DiffviewOpen<cr>",             desc = "Diff view (working tree)" },
        { "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",    desc = "File history (current file)" },
        { "<leader>gH", "<cmd>DiffviewFileHistory<cr>",      desc = "File history (repo)" },
    },
    opts = {
        enhanced_diff_hl = true,
        view = {
            default = { layout = "diff2_horizontal" },
            merge_tool = { layout = "diff3_horizontal" },
        },
    },
}
