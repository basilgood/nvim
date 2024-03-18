return {
  'luozhiya/lsp-virtual-improved.nvim',
  event = { 'LspAttach' },
  config = function()
    require('lsp-virtual-improved').setup()

    vim.diagnostic.config({
      virtual_text = false,
      underline = false,
      float = {
        source = 'always',
        border = 'single',
        header = '',
      },
      virtual_improved = {
        current_line = 'only',
      },
      virtual_lines = false,
    })
  end,
  keys = {},
  dependencies = {
    'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
    opts = {},
    keys = {
      {
        '<leader>l',
        '<cmd>lua require("lsp_lines").toggle()<cr>',
      },
    },
  },
}
