return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signs = {
            add          = { text = "▎" },
            change       = { text = "▎" },
            delete       = { text = "" },
            topdelete    = { text = "" },
            changedelete = { text = "▎" },
            untracked    = { text = "▎" },
        },
        current_line_blame = false,
        on_attach = function(bufnr)
            local gs = package.loaded.gitsigns
            local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
            end

            -- Hunk navigation
            map("n", "]h", function()
                if vim.wo.diff then return "]h" end
                vim.schedule(gs.next_hunk)
                return "<Ignore>"
            end, "Next hunk")
            map("n", "[h", function()
                if vim.wo.diff then return "[h" end
                vim.schedule(gs.prev_hunk)
                return "<Ignore>"
            end, "Prev hunk")

            -- Staging
            map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage hunk")
            map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset hunk")
            map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
            map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
            map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")

            -- Inspect
            map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
            map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame line")
            map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle line blame")
            map("n", "<leader>gd", gs.diffthis, "Diff this")

            -- Text object: select hunk with ih
            map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
        end,
    },
}
