function config()
  local function project()
    local cwd = vim.fn.getcwd()
    -- Remove /Users/t/Projects/
    return cwd:sub(19)
  end

  local function filename_relative_path()
    local relative_path = vim.fn.expand("%")
    return require("path").format(relative_path)
  end

  require("lualine").setup(
    {
      themes = "gruvbox_dark",
      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end
          }
        },
        lualine_b = {
          {
            "branch",
            fmt = function(branch_name)
              if branch_name:len() > 15 then
                return branch_name:sub(1, 14) .. ".."
              end
              return branch_name
            end
          },
          "diff",
          "diagnostics"
        },
        lualine_c = {{project}, {filename_relative_path}}
      },
      inactive_sections = {
        lualine_c = {{project}, {filename_relative_path}}
      }
    }
  )
end

return {
  {
    "nvim-lualine/lualine.nvim",
    config = config
  },
  {
    "edkolev/tmuxline.vim",
    init = function()
      print("tmuxline")
    end
  } -- Makes tmux status line match vim status line
}
