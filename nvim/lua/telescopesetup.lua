require("telescope").setup(
  {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob",
        "!.git"
      },
      layout_strategy = "vertical",
      layout_config = {
        height = 0.95,
        width = 0.95,
        flex = {
          flip_columns = 120
        }
      },
      mappings = {
        i = {
          ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist
        },
        n = {
          ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist
        }
      }
    }
  }
)

_G.select_layout = function(builtin, opts)
  if not opts then
    opts = {}
  end

  opts.layout_strategy = "vertical"

  opts.path_display = function(_, path)
    return require("path").format(path)
  end
  builtin(opts)
end

local find_files = function(opts)
  if not opts then
    opts = {}
  end

  opts.find_command = {"rg", "--files", "--hidden", "--glob", "!.git"}
  select_layout(require("telescope.builtin").find_files, opts)
end

_G.project_files = function()
  local ok = pcall(select_layout, require("telescope.builtin").git_files)
  if not ok then
    find_files()
  end
end

_G.all_project_files = function()
  local opts = {
    cwd = "/Users/t/Projects"
  }
  find_files(opts)
end

_G.buffers = function()
  local opts = {
    ignore_current_buffer = true,
    sort_mru = true
  }
  select_layout(require("telescope.builtin").buffers, opts)
end

local map = vim.api.nvim_set_keymap
map("n", "<leader>p", "<cmd>lua project_files()<cr>", {noremap = true})
map("n", "<leader>P", "<cmd>lua all_project_files()<cr>", {noremap = true})
map("n", "<leader>l", "<cmd>lua select_layout(require('telescope.builtin').live_grep)<cr>", {noremap = true})
map("n", "<leader>g", "<cmd>lua select_layout(require('telescope.builtin').git_status)<cr>", {noremap = true})
map("n", "<leader>b", "<cmd>lua buffers()<cr>", {noremap = true})
map("n", "<leader>H", "<cmd>lua select_layout(require('telescope.builtin').help_tags)<cr>", {noremap = true})
