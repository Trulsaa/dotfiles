return {
  "epwalsh/obsidian.nvim",
  config = function()
    require("obsidian").setup(
      {
        dir = "/Users/t/Library/Mobile Documents/iCloud~md~obsidian/Documents/Notater",
        daily_notes = {
          folder = "Daily"
        },
        completion = {
          nvim_cmp = true -- if using nvim-cmp, otherwise set to false
        }
      }
    )
  end
}
