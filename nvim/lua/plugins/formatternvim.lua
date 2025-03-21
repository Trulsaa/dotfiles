return {
  "mhartington/formatter.nvim",
  config = function()
    local formatter = require("formatter.filetypes")
    require("formatter").setup({
      filetype = {
        javascript = { formatter.javascript.prettierd },
        typescript = { formatter.typescript.prettierd },
        typescriptreact = { formatter.typescriptreact.prettierd },
        javascriptreact = { formatter.javascriptreact.prettierd },
        vue = { formatter.vue.prettierd },
        json = { formatter.json.prettierd },
        markdown = { formatter.markdown.prettierd },
        html = { formatter.html.prettierd },
        yaml = { formatter.yaml.prettierd },
        lua = { formatter.lua.stylua },
        terraform = { formatter.terraform.terraformfmt },
        sh = { formatter.sh.shfmt },
        zsh = { formatter.sh.shfmt },
        go = { formatter.go.gofmt },
        rust = { formatter.rust.rustfmt },
        python = { formatter.python.black },
      },
    })

    vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
  end,
}
