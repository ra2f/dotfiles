local themes = {
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  },
}

local selectedTheme = themes[vim.g.config.theme.name]

return selectedTheme
