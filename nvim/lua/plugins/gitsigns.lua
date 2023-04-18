function on_attach(bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  local gs = package.loaded.gitsigns

  -- Navigation
  map(
    "n",
    "]c",
    function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(
        function()
          gs.next_hunk()
        end
      )
      return "<Ignore>"
    end,
    {expr = true}
  )

  map(
    "n",
    "[c",
    function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(
        function()
          gs.prev_hunk()
        end
      )
      return "<Ignore>"
    end,
    {expr = true}
  )

  -- Actions
  map({"n", "v"}, "<leader>hs", ":Gitsigns stage_hunk<CR>")
  map({"n", "v"}, "<leader>hr", ":Gitsigns reset_hunk<CR>")
  map("n", "<leader>hS", gs.stage_buffer)
  map("n", "<leader>hu", gs.undo_stage_hunk)
  map("n", "<leader>hR", gs.reset_buffer)
  map("n", "<leader>hp", gs.preview_hunk)
  map(
    "n",
    "<leader>hb",
    function()
      gs.blame_line {full = true}
    end
  )

  -- Text object
  map({"o", "x"}, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

return {
  "lewis6991/gitsigns.nvim",
  dependencies = {"nvim-lua/plenary.nvim"},
  config = function()
    require("gitsigns").setup(
      {
        signs = {
          delete = {show_count = true},
          topdelete = {show_count = true},
          changedelete = {show_count = true}
        },
        on_attach = on_attach
      }
    )
  end
}
