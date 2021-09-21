-- Global mappings
-- ===============
local map = vim.api.nvim_set_keymap

-- map the leader key
map("n", "<Space>", "", {})
vim.g.mapleader = " " -- 'vim.g' sets global variables

map("n", "<leader>p", "<cmd>lua project_files()<cr>", { noremap = true })
map("n", "<leader>P", "<cmd>lua all_project_files()<cr>", { noremap = true })
map("n", "<leader>l", "<cmd>lua select_layout(require('telescope.builtin').live_grep)<cr>", { noremap = true })
map("n", "<leader>g", "<cmd>lua select_layout(require('telescope.builtin').git_status)<cr>", { noremap = true })
map("n", "<leader>b", "<cmd>lua buffers()<cr>", { noremap = true })
map("n", "<leader>H", "<cmd>lua select_layout(require('telescope.builtin').help_tags)<cr>", { noremap = true })
