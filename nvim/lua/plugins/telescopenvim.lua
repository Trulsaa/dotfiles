local function config()
  require("telescope").setup({
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
        "!.git",
      },
      layout_strategy = "vertical",
      layout_config = {
        height = 0.95,
        width = 0.95,
        flex = {
          flip_columns = 120,
        },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })

  require("telescope").load_extension("fzf")

  local select_layout = require("select_layout").select_layout

  local find_files = function(opts)
    if not opts then
      opts = {}
    end

    opts.find_command = { "rg", "--files", "--hidden", "--glob", "!.git", "--glob", "!.DS_Store" }
    select_layout(require("telescope.builtin").find_files, opts)()
  end

  local notes_files = function()
    local opts = {
      cwd = "/Users/t/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notater",
      find_command = { "rg", "--files" },
    }
    select_layout(require("telescope.builtin").find_files, opts)()
  end
  vim.api.nvim_create_user_command("Notes", notes_files, {})

  local project_files = function()
    if string.sub(vim.fn.getcwd(), -string.len("Notater")) == "Notater" then
      notes_files()
    else
      local ok = pcall(select_layout(require("telescope.builtin").git_files))
      if not ok then
        find_files()
      end
    end
  end

  local all_project_files = function()
    local opts = {
      cwd = "/Users/t/Projects",
    }
    find_files(opts)
  end

  local buffers = function()
    local opts = {
      ignore_current_buffer = true,
      sort_mru = true,
    }
    select_layout(require("telescope.builtin").buffers, opts)()
  end

  local map = vim.keymap.set
  map("n", "<leader>p", require("telescope.builtin").commands)
  map("n", "<leader>o", project_files)
  map("n", "<leader>O", all_project_files)
  map("n", "<leader>l", select_layout(require("telescope.builtin").live_grep))
  map("n", "<leader>g", select_layout(require("telescope.builtin").git_status))
  map("n", "<leader>G", require("telescope.builtin").git_branches)
  map("n", "<leader>b", buffers)
  map("n", "<leader>H", select_layout(require("telescope.builtin").help_tags))
end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      config = function()
        require("telescope").setup({
          extensions = {
            ["ui-select"] = {
              require("telescope.themes").get_cursor({}),
            },
          },
        })
        require("telescope").load_extension("ui-select")
      end,
    },
    "nvim-lua/plenary.nvim",
  },
  config = config,
}
