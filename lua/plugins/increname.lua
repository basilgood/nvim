return {
  'smjonas/inc-rename.nvim',
  event = { 'LspAttach' },
  opts = {},
  keys = {
    { '<f2>', ':IncRename ' },
  },
}
