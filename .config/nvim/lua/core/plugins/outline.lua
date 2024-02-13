local icons = require("utils.icons")
local M = {
  "hedyhli/outline.nvim",
  cmd = { "Outline", "OutlineOpen" },
  opts = {
    symbol_folding = {
      -- Depth past which nodes will be folded by default
      autofold_depth = 1,
    },
  },
  keys = {
    { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" },
  },
  config = function()
    require("outline").setup({
      outline_window = {
        auto_jump = true,
      },
      outline_items = {
        show_symbol_details = false,
      },
      symbol_folding = {
        autofold_depth = 1,
        auto_unfold_hover = true,
      },
      keymaps = {
        close = {},
        fold_toggle = { "<Left>", "<Right>" },
        fold_toggle_all = {},
        down_and_goto = {},
        up_and_goto = {},
      },
      preview_window = {
        border = "rounded",
      },
      guides = {
        enabled = true,
        markers = {
          bottom = "└",
          middle = "├",
          vertical = "",
          horizontal = "─",
        },
      },
      symbols = {
        icons = {
          Array = { icon = icons.ui.Array, hl = "@constant" },
          Boolean = { icon = icons.ui.Boolean, hl = "@boolean" },
          Class = { icon = "𝓒", hl = "@type" },
          Constant = { icon = icons.ui.Constant, hl = "@constant" },
          Constructor = { icons.ui.Constructor, hl = "@constructor" },
          Enum = { icon = icons.ui.Enum, hl = "@type" },
          EnumMember = { icon = icons.ui.EnumMember, hl = "@field" },
          Event = { icon = icons.ui.Event, hl = "@type" },
          Field = { icon = icons.ui.Field, hl = "@field" },
          File = { icon = icons.ui.File, hl = "@text.uri" },
          Function = { icon = icons.ui.Function, hl = "@function" },
          Interface = { icon = icons.ui.Interface, hl = "@type" },
          Key = { icon = icons.ui.Key, hl = "@type" },
          Method = { icon = icons.ui.Function, hl = "@method" },
          Module = { icon = icons.ui.Module, hl = "@namespace" },
          Namespace = { icon = icons.ui.Namespace, hl = "@namespace" },
          Number = { icon = icons.ui.Number, hl = "@number" },
          Null = { icon = "NULL", hl = "@type" },
          Object = { icon = icons.ui.Object, hl = "@type" },
          Operator = { icon = icons.ui.Operator, hl = "@operator" },
          Property = { icon = icons.ui.Property, hl = "@method" },
          String = { icon = icons.ui.String, hl = "@string" },
          Struct = { icon = icons.ui.Struct, hl = "@type" },
          TypeParameter = { icon = icons.ui.TypeParameter, hl = "@parameter" },
          Variable = { icon = icons.ui.Variable, hl = "@constant" },
        },
      },
    })
  end
}

return M
