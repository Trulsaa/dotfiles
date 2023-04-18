return {
  "mfussenegger/nvim-lint",
  config = function()
    local nvim_lint = require("lint")
    nvim_lint.linters_by_ft = {
      sh = { "shellcheck" },
      typescript = { "eslint_d" },
      lua = { "luacheck" },
      dockerfile = { "hadolint" },
      yaml = { "yamllint" },
      terraform = { "tflint" },
    }
    local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]]
    local groups = { "lnum", "col", "severity", "message", "code" }
    local severity_map = {
      ["error"] = vim.diagnostic.severity.ERROR,
      ["warn"] = vim.diagnostic.severity.WARN,
      ["warning"] = vim.diagnostic.severity.WARN,
    }

    nvim_lint.linters.eslint_d = {
      cmd = "eslint_d",
      args = {},
      stdin = false,
      stream = "stdout",
      ignore_exitcode = true,
      parser = require("lint.parser").from_pattern(pattern, groups, severity_map, { ["source"] = "eslint_d" }),
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      buffer = 0, -- current buffer has buffer number 0
      desc = "Lint on save",
      callback = nvim_lint.try_lint,
    })
  end,
}
