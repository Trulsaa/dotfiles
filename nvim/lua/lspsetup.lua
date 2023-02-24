local nvim_lsp = require("lspconfig")
local nvim_cmp_capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
local select_layout = require("telescopesetup").select_layout

-- Set color for error message
vim.cmd("hi LspDiagnosticsDefaultError ctermfg=Red")

local conf = require("telescope.config").values
local finders = require("telescope.finders")
local make_entry = require("telescope.make_entry")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions.state")

local function table_to_string(tbl)
  local result = "{"
  for k, v in pairs(tbl) do
    -- Check the key type (ignore any numerical keys - assume its an array)
    if type(k) == "string" then
      result = result .. '["' .. k .. '"]' .. "="
    end

    -- Check the value type
    if type(v) == "table" then
      result = result .. table_to_string(v)
    elseif type(v) == "boolean" then
      result = result .. tostring(v)
    else
      result = result .. '"' .. v .. '"'
    end
    result = result .. ","
  end
  -- Remove leading commas from the result
  if result ~= "" then
    result = result:sub(1, result:len() - 1)
  end
  return result .. "}"
end

local references = function(opts)
  local params = vim.lsp.util.make_position_params()
  params.context = {includeDeclaration = true}

  local results_lsp, err = vim.lsp.buf_request_sync(0, "textDocument/references", params, opts.timeout or 10000)
  if err then
    vim.api.nvim_err_writeln("Error when finding references: " .. err)
    return
  end

  local concatinated_results = {}
  for _, server_results in pairs(results_lsp) do
    if server_results.result then
      vim.list_extend(concatinated_results, server_results.result or {})
    end
  end

  local unique_results = {}
  for _, result in pairs(concatinated_results) do
    unique_results[table_to_string(result)] = result
  end

  local indexed_results = {}
  local index = 1
  for _, result in pairs(unique_results) do
    indexed_results[index] = result
    index = index + 1
  end

  local locations = vim.lsp.util.locations_to_items(indexed_results)

  if vim.tbl_isempty(locations) then
    return
  end

  for _, location in pairs(locations) do
    local newFileName = require("path").removeCwdFromPath(location.filename)
    location.filename = newFileName
  end

  pickers.new(
    opts,
    {
      prompt_title = "LSP References",
      finder = finders.new_table(
        {
          results = locations,
          entry_maker = opts.entry_maker or make_entry.gen_from_quickfix(opts)
        }
      ),
      previewer = conf.qflist_previewer(opts),
      sorter = conf.generic_sorter(opts)
    }
  ):find()
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map("n", "gD", vim.lsp.buf.declaration)
  map("n", "gd", select_layout(require("telescope.builtin").lsp_definitions))
  map("n", "K", vim.lsp.buf.hover)
  map("n", "gi", select_layout(require("telescope.builtin").lsp_implementations))
  map("n", "gR", select_layout(references))
  map("n", "<space>D", vim.lsp.buf.type_definition)
  map("n", "<space>rn", vim.lsp.buf.rename)
  map("n", "<space>A", vim.lsp.buf.code_action)
  map("v", "<space>A", vim.lsp.buf.range_code_action)
  map("n", "<space>s", select_layout(require("telescope.builtin").lsp_workspace_symbols))
  map("n", "<space>E", select_layout(require("telescope.builtin").diagnostics))
  map("n", "<space>e", vim.diagnostic.open_float)
  map("n", "[d", vim.diagnostic.goto_prev)
  map("n", "]d", vim.diagnostic.goto_next)
  map("n", "<space>q", vim.diagnostic.setloclist)
end

local project_library_path = "/usr/local/lib/node_modules"
local cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  project_library_path,
  "--ngProbeLocations",
  project_library_path
}
nvim_lsp.angularls.setup(
  {
    on_attach = on_attach,
    capabilities = nvim_cmp_capabilities,
    flags = {
      debounce_text_changes = 150
    },
    cmd = cmd,
    on_new_config = function(new_config)
      new_config.cmd = cmd
    end,
    filetypes = {"typescript", "html"}
  }
)
nvim_lsp.jsonls.setup(
  {
    settings = {
      json = {
        validate = {enable = true},
        schemas = require("schemastore").json.schemas()
      }
    },
    capabilities = nvim_cmp_capabilities,
    on_attach = function(client, bufnr)
      -- Disable document_formatting from lsp
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150
    }
  }
)

-- Plugin gives error
--[[ nvim_lsp.yamlls.setup {
  settings = {
    on_attach = on_attach,
    capabilities = nvim_cmp_capabilities,
    yaml = {
      validate = {enable = true},
      schemas = require("schemastore").json.schemas()
    }
  }
} ]]
local lsp_organize_imports = function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup(
  {
    capabilities = nvim_cmp_capabilities,
    on_attach = function(client, bufnr)
      -- Disable document_formatting from lsp
      client.server_capabilities.document_formatting = false
      vim.keymap.set(
        "n",
        "<space>i",
        lsp_organize_imports,
        {
          silent = true,
          buffer = bufnr
        }
      )
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150
    }
  }
)
nvim_lsp.vuels.setup(
  {
    capabilities = nvim_cmp_capabilities,
    on_attach = function(client, bufnr)
      -- Disable document_formatting from lsp
      client.server_capabilities.document_formatting = false
      on_attach(client, bufnr)
    end,
    flags = {
      debounce_text_changes = 150
    }
  }
)
nvim_lsp.omnisharp.setup(
  {
    capabilities = nvim_cmp_capabilities,
    on_attach = on_attach,
    cmd = {
      "/Users/t/bin/omnisharp-osx/run",
      "--languageserver",
      "--hostPID",
      tostring(vim.fn.getpid())
    }
  }
)

nvim_lsp.lemminx.setup(
  {
    capabilities = nvim_cmp_capabilities,
    on_attach = on_attach,
    cmd = {"/Users/t/bin/lemminx-osx-x86_64"}
  }
)

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig").lua_ls.setup(
  {
    capabilities = nvim_cmp_capabilities,
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {"vim"}
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true)
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false
        }
      }
    }
  }
)

-- /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/macOS/lua-language-server -E /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/main.lua
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
  "tflint"
}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup(
    {
      capabilities = nvim_cmp_capabilities,
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150
      }
    }
  )
end

nvim_lsp.kotlin_language_server.setup(
  {
    cmd = {
      "/Users/t/Projects/kotlin-language-server/server/build/install/server/bin/kotlin-language-server"
    }
  }
)

local jdtls_setup = function()
  local jdtls = require("jdtls")
  local jdtls_on_attach = function(_, bufnr)
    on_attach(_, bufnr)

    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Java specific
    map("n", "<space>i", jdtls.organize_imports)
    map("n", "<space>dt", jdtls.test_class)
    map("n", "<space>dn", jdtls.test_nearest_method)
    map("n", "<space>de", jdtls.extract_variable)

    map("v", "<space>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>")
    map("v", "<space>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>")
  end

  local root_markers = {"gradlew", "pom.xml"}
  local root_dir = jdtls.setup.find_root(root_markers)
  local home = os.getenv("HOME")
  local workspace_folder = home .. "/.workspace" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  local config = {
    flags = {
      allow_incremental_sync = true
    },
    capabilities = nvim_cmp_capabilities,
    on_attach = jdtls_on_attach,
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      "/Users/t/bin/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
      "-configuration",
      "/Users/t/bin/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_mac",
      "-data",
      workspace_folder
    },
    on_init = function(client, _)
      client.notify("workspace/didChangeConfiguration", {settings = config.settings})
    end
  }

  local extendedClientCapabilities = jdtls.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
  config.init_options = {
    -- bundles = bundles;
    extendedClientCapabilities = extendedClientCapabilities
  }

  -- UI
  require("jdtls.ui").pick_one_async = function(items, prompt, label_fn, cb)
    local opts = {}
    pickers.new(
      opts,
      {
        prompt_title = prompt,
        finder = finders.new_table {
          results = items,
          entry_maker = function(entry)
            return {
              value = entry,
              display = label_fn(entry),
              ordinal = label_fn(entry)
            }
          end
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr)
          actions.goto_file_selection_edit:replace(
            function()
              local selection = actions.get_selected_entry()
              actions.close(prompt_bufnr)

              cb(selection.value)
            end
          )

          return true
        end
      }
    ):find()
  end

  -- Server
  jdtls.start_or_attach(config)
end

local jdtls_setup_group_id = vim.api.nvim_create_augroup("jdtls_setup_group", {clear = true})
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = "java",
    desc = "Setup jdtls",
    group = jdtls_setup_group_id,
    callback = jdtls_setup
  }
)
