vim.keymap.set("n", "<leader>dN", function() require"dap-go".debug_test() end, { desc = "[D]ebug [N]earest" })
vim.keymap.set("n", "<leader>dP", function() require"dap-go".debug_last_test() end, { desc = "[D]ebug [P]revious" })

vim.opt_local.tabstop = 4
