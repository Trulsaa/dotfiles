return {
  {
    "dpayne/CodeGPT.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim"}
  },
  {
    "jackMort/ChatGPT.nvim",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}
