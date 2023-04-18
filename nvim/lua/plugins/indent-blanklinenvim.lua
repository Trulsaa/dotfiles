-- Vertical indent guide lines
return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPost",
  opts = {
    filetype_exclude = {
      "help",
      "markdown",
      "terminal"
    },
    char = "│",
    use_treesitter = true,
    show_current_context = true,
    show_current_context_start = true,
    show_trailing_blankline_indent = false
  }
}
