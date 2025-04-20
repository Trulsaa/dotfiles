  -- HIGHLIGHTING
  return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag", -- Autoclose and autorename html tag
      "nvim-treesitter/nvim-treesitter-refactor",
      "nvim-treesitter/nvim-treesitter-context"
    },
    config = function()
      require("nvim-treesitter.configs").setup(
        {
          ensure_installed = "all",
          highlight = {
            enable = true -- false will disable the whole extension
          },
          incremental_selection = {enable = true},
          textobjects = {enable = true},
          refactor = {
            highlight_definitions = {enable = true},
            highlight_current_scope = {enable = false}
          }
        }
      )
      -- make highlight_definitions react after 500 ms not 4000 ms (default)
      vim.o.updatetime = 500

      require("nvim-ts-autotag").setup()
    end
  }
