require('diagflow').setup({ scope = 'line' })

vim.diagnostic.config({
  underline = false,
  float = {
    border = 'single',
    header = '',
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.HINT] = 'ʰ',
      [vim.diagnostic.severity.ERROR] = 'ᵉ',
      [vim.diagnostic.severity.INFO] = 'ⁱ',
      [vim.diagnostic.severity.WARN] = 'ʷ',
    },
  },
})
vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
