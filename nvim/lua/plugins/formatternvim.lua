return {
  "mhartington/formatter.nvim",
  config = function()
    local formatter = require("formatter.filetypes")
    require("formatter").setup({
      filetype = {
        javascript = { formatter.javascript.prettier },
        typescript = { formatter.typescript.prettier },
        typescriptreact = { formatter.typescriptreact.prettier },
        javascriptreact = { formatter.javascriptreact.prettier },
        vue = { formatter.vue.prettier },
        json = { formatter.json.prettier },
        markdown = { formatter.markdown.prettier },
        html = { formatter.html.prettier },
        yaml = { formatter.yaml.prettier },
        lua = { formatter.lua.stylua },
        terraform = { formatter.terraform.terraformfmt },
        sh = { formatter.sh.shfmt },
        zsh = { formatter.sh.shfmt },
        go = { formatter.go.gofmt },
      },
    })

    vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
  end,
}
