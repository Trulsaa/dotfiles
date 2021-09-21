local nvim_lsp = require("lspconfig")

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = {
        noremap = true,
        silent = true
    }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd",
                   "<cmd>lua select_layout(require('telescope.builtin').lsp_definitions)<cr>",
                   opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi",
                   "<cmd>lua select_layout(require('telescope.builtin').lsp_implementations)<cr>",
                   opts)
    buf_set_keymap("n", "gR",
                   "<cmd>lua select_layout(require('telescope.builtin').lsp_references)<cr>",
                   opts)
    buf_set_keymap("n", "<space>D",
                   "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>A",
                   "<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<cr>",
                   opts)
    buf_set_keymap("v", "<space>A",
                   "<cmd>lua require('telescope.builtin').lsp_range_code_actions(require('telescope.themes').get_cursor())<cr>",
                   opts)
    buf_set_keymap("n", "<space>s",
                   "<cmd>lua select_layout(require('telescope.builtin').lsp_workspace_symbols)<cr>",
                   opts)
    buf_set_keymap("n", "<space>e",
                   "<cmd>lua select_layout(require('telescope.builtin').lsp_workspace_diagnostics)<cr>",
                   opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>",
                   opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
                   opts)
    buf_set_keymap("n", "<space>q",
                   "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>",
                   opts)

    require("lsp_signature").on_attach({
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
            border = "none"
        },
        padding = " ",
        hint_enable = false
    }, bufnr)
end

local formatters = {
    prettier = {
        command = "prettier",
        args = {"--stdin-filepath", "%filepath"}
    },
    stylua = {
        command = "stylua",
        args = {"--indent-width", 2, "--indent-type", "Spaces", "%file"},
        doesWriteToFile = true
    },
    luaformat = {
        command = "lua-format",
        args = {
            "-in-place", "--no-keep-simple-function-one-line",
            "--no-break-after-operator", "--column-limit=80",
            "--break-after-table-lb"
        }
    }
}
local formatFiletypes = {
    javascript = "prettier",
    typescript = "prettier",
    typescriptreact = "prettier",
    vue = "prettier",
    json = "prettier",
    markdown = "prettier",
    html = "prettier",
    yaml = "prettier",
    sh = "prettier",
    lua = "luaformat"
}

nvim_lsp.diagnosticls.setup({
    on_attach = on_attach,
    filetypes = vim.tbl_keys(formatFiletypes),
    init_options = {
        formatters = formatters,
        formatFiletypes = formatFiletypes
    }
})

local project_library_path = "/usr/local/lib/node_modules"
local cmd = {
    "ngserver", "--stdio", "--tsProbeLocations", project_library_path,
    "--ngProbeLocations", project_library_path
}
nvim_lsp.angularls.setup({
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150
    },
    cmd = cmd,
    on_new_config = function(new_config, new_root_dir)
        new_config.cmd = cmd
    end,
    filetypes = {"typescript", "html"}
})
nvim_lsp.jsonls.setup({
    on_attach = function(client, bufnr)
        -- Disable document_formatting from lsp
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150
    }
})

_G.lsp_organize_imports = function()
    local params = {
        command = "_typescript.organizeImports",
        arguments = {vim.api.nvim_buf_get_name(0)},
        title = ""
    }
    vim.lsp.buf.execute_command(params)
end

nvim_lsp.tsserver.setup({
    on_attach = function(client, bufnr)
        -- Disable document_formatting from lsp
        client.resolved_capabilities.document_formatting = false
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>i",
                                    "<cmd>lua lsp_organize_imports()<CR>", {
            noremap = true,
            silent = true
        })
        on_attach(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150
    }
})
nvim_lsp.vuels.setup({
    on_attach = function(client, bufnr)
        -- Disable document_formatting from lsp
        client.resolved_capabilities.document_formatting = false
        on_attach(client, bufnr)
    end,
    flags = {
        debounce_text_changes = 150
    }
})
nvim_lsp.omnisharp.setup({
    on_attach = on_attach,
    cmd = {
        "/Users/t/bin/omnisharp-osx/run", "--languageserver", "--hostPID",
        tostring(vim.fn.getpid())
    }
})

local system_name = "macOS"
local sumneko_root_path = "/Users/t/Projects/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name
                           .. "/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").sumneko_lua.setup({
    on_attach = on_attach,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
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
})

-- /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/bin/macOS/lua-language-server -E /Users/t/.cache/nvim/lspconfig/sumneko_lua/lua-language-server/main.lua
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
    "vimls", "bashls", "dockerls", "gopls", "graphql", "html", "terraformls",
    "tflint", "jdtls"
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    })
end

