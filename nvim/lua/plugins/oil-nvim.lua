return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      delete_to_trash = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
        -- This function defines what is considered a "hidden" file
        is_hidden_file = function(name, bufnr)
          return vim.startswith(name, ".")
        end,
        -- This function defines what will never be shown, even when `show_hidden` is set
        is_always_hidden = function(name, bufnr)
          return name == ".." or name == ".DS_Store"
        end,
        sort = {
          -- sort order can be "asc" or "desc"
          -- see :help oil-columns to see which columns are sortable
          { "type", "asc" },
          { "name", "asc" },
        },
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-x>"] = "actions.select_split",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-t>"] = "actions.open_terminal",
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = "actions.open_cmdline_dir",
        ["<C-l>"] = false,
        ["<C-r>"] = "actions.refresh",
        ["-"] = "actions.parent",
        ["_"] = false,
        ["`"] = false,
        ["~"] = false,
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = false,
        ["g\\"] = false,
      },
    })
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
