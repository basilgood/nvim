return {
  'ellisonleao/gruvbox.nvim',
  name = 'gruvbox',
  priority = 1000,
  opts = {
    underline = false,
    italic = {
      strings = false,
      emphasis = false,
      comments = false,
      folds = false,
    },
    overrides = {
      String = { fg = '#8ec07c' },
      FloatBorder = { fg = '#444444' },
      FzfLuaBorder = { link = 'FloatBorder' },
      FzfLuaTitle = { link = 'Number' },
      MiniIndentscopeSymbol = { fg = '#444444' },
    },
  },
}
