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
    },
    layout_config = {
      height = 0.95,
      width = 0.95,
      flex = {
        flip_columns = 120,
      },
    },
    mappings = {
      i = {
        ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
      },
      n = {
        ["<C-q>"] = require("telescope.actions").smart_send_to_qflist + require("telescope.actions").open_qflist,
      },
    },
  },
})

_G.select_layout = function(builtin, opts)
  if not opts then
    opts = {}
  end

  opts.layout_strategy = "flex"

  opts.path_display = function(opts, path)
    local cwd = vim.fn.getcwd()
    if string.find(cwd .. path, "aize/vcp") ~= nil then
      local shortApplications = string.gsub(path, "applications", "a")
      local transformed_path = string.gsub(shortApplications, "java/io/aize/vcp/clientapi", "...")
      return transformed_path
    else
      return path
    end
  end
  builtin(opts)
end

_G.project_files = function()
  local ok = pcall(select_layout, require("telescope.builtin").git_files)
  if not ok then
    select_layout(require("telescope.builtin").find_files)
  end
end

_G.all_project_files = function()
  local opts = {
    cwd = "/Users/t/Projects",
    hidden = true,
  }
  select_layout(require("telescope.builtin").find_files, opts)
end

_G.buffers = function()
  local opts = {
    ignore_current_buffer = true,
    sort_mru = true,
  }
  select_layout(require("telescope.builtin").buffers, opts)
end

