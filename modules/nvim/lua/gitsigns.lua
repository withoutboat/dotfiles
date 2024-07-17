require("gitsigns").setup()

vim.keymap.set("n", "<leader>gj", require("gitsigns").next_hunk, { desc = "Next Hunk" })
vim.keymap.set("n", "<leader>gk", require("gitsigns").prev_hunk, { desc = "Prev Hunk" })
vim.keymap.set("n", "<leader>gp", require("gitsigns").preview_hunk, { desc = "Preview Hunk" })
vim.keymap.set("n", "<leader>gr", require("gitsigns").reset_hunk, { desc = "Reset Hunk" })
vim.keymap.set("n", "<leader>gs", require("gitsigns").stage_hunk, { desc = "Stage Hunk" })
vim.keymap.set("n", "<leader>gu", require("gitsigns").undo_stage_hunk, { desc = "Undo Stage Hunk" })
