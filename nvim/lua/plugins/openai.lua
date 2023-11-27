local isStartedInProjects = require("isStartedInProjects")
return {
  {
    "dpayne/CodeGPT.nvim",
    cond = isStartedInProjects,
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
  },
  {
    "jackMort/ChatGPT.nvim",
    cond = isStartedInProjects,
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
}
