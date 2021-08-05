local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
  buf_set_keymap('n', 'gR', "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>A', "<cmd>lua require('telescope.builtin').lsp_code_actions()<cr>", opts)
  buf_set_keymap('v', '<space>A', "<cmd>lua require('telescope.builtin').lsp_range_code_actions()<cr>", opts)
  buf_set_keymap('n', '<space>s', "<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>", opts)
  buf_set_keymap('n', '<space>e', "<cmd>lua require('telescope.builtin').lsp_workspace_diagnostics()<cr>", opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

local formatters = {
    prettier = {command = "prettier", args = {"--stdin-filepath", "%filepath"}}
}
local formatFiletypes = {
    javascript = "prettier",
    typescript = "prettier",
    typescriptreact = "prettier",
    vue = "prettier",
    json = "prettier",
    markdown = "prettier"
}
nvim_lsp.diagnosticls.setup {
    on_attach = on_attach,
    filetypes = vim.tbl_keys(formatFiletypes),
    init_options = {
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
}

local project_library_path = "/usr/local/lib/node_modules"
local cmd = {"ngserver", "--stdio", "--tsProbeLocations", project_library_path , "--ngProbeLocations", project_library_path}
nvim_lsp.angularls.setup{
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  cmd = cmd,
  on_new_config = function(new_config,new_root_dir)
    new_config.cmd = cmd
  end,
  filetypes = { "typescript", "html" }
}
nvim_lsp.jsonls.setup {
  on_attach = function(client, bufnr)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup {
  on_attach = function(client, bufnr)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>i", "<cmd>lua lsp_organize_imports()<CR>", { noremap=true, silent=true })
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}
nvim_lsp.vuels.setup {
  on_attach = function(client)
    -- Disable document_formatting from lsp
    client.resolved_capabilities.document_formatting = false
    on_attach(client, bufnr)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  "vimls",
  "bashls",
  "dockerls",
  "gopls",
  "graphql",
  "html",
  "terraformls",
  "tflint",
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'compe'.setup({
  enabled = true,
  source = {
    path = true,
    buffer = true,
    nvim_lsp = true,
    nvim_lua = true,
    ultisnips = true,
    treesitter = true,
  },
})
vim.o.completeopt = "menuone,noselect"

require('gitsigns').setup()

require('telescope').setup({
  defaults = {
    layout_config = {
      height = 0.95,
      width = 0.95
    }
  }
})

_G.project_files = function()
  local opts = {} -- define here if you want to define something
  local ok = pcall(require'telescope.builtin'.git_files, opts)
  if not ok then require'telescope.builtin'.find_files(opts) end
end

-- Global mappings
-- ===============
local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '  -- 'vim.g' sets global variables

map('n', '<leader>p', "<cmd>lua project_files()<cr>", { noremap = true })
map('n', '<leader>P', "<cmd>lua require('telescope.builtin').file_browser({ cwd = '~/Projects' })<cr>", { noremap = true })
map('n', '<leader>l', "<cmd>lua require('telescope.builtin').live_grep()<cr>", { noremap = true })
map('n', '<leader>g', "<cmd>lua require('telescope.builtin').git_status()<cr>", { noremap = true })
map('n', '<leader>b', "<cmd>lua require('telescope.builtin').buffers()<cr>", { noremap = true })
map('n', '<leader>H', "<cmd>lua require('telescope.builtin').help_tags()<cr>", { noremap = true })
