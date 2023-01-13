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
      }
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    }
  }
)

require("telescope").load_extension("fzf")

local select_layout = function(builtin, opts)
  if not opts then
    opts = {}
  end

  opts.layout_strategy = "vertical"

  opts.path_display = function(_, path)
    return require("path").format(path)
  end

  return function()
    builtin(opts)
  end
end

local find_files = function(opts)
  if not opts then
    opts = {}
  end

  opts.find_command = {"rg", "--files", "--hidden", "--glob", "!.git"}
  select_layout(require("telescope.builtin").find_files, opts)()
end

local project_files = function()
  local ok = pcall(select_layout(require("telescope.builtin").git_files))
  if not ok then
    find_files()
  end
end

local all_project_files = function()
  local opts = {
    cwd = "/Users/t/Projects"
  }
  find_files(opts)
end

local buffers = function()
  local opts = {
    ignore_current_buffer = true,
    sort_mru = true
  }
  select_layout(require("telescope.builtin").buffers, opts)()
end

local map = vim.keymap.set
map("n", "<leader>p", project_files)
map("n", "<leader>P", all_project_files)
map("n", "<leader>l", select_layout(require("telescope.builtin").live_grep))
map("n", "<leader>g", select_layout(require("telescope.builtin").git_status))
map("n", "<leader>G", require("telescope.builtin").git_branches)
map("n", "<leader>b", buffers)
map("n", "<leader>H", select_layout(require("telescope.builtin").help_tags))

return {select_layout = select_layout}
