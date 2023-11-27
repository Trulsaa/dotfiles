local isStartedInProjects = require("isStartedInProjects")

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    cond = isStartedInProjects,
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    cond = isStartedInProjects,
    config = function()
      require("copilot_cmp").setup()
    end,
  },
}
