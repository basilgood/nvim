local map = vim.keymap.set
local conform = require('conform')

conform.setup({
  formatters = {
    shfmt = {
      prepend_args = { '-i', '2', '-ci' },
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    yaml = { 'prettier' },
    nix = { 'alejandra' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    json = { lsp_format = 'prefer' },
    jsonc = { lsp_format = 'prefer' },
  },
})
map('n', '<f3>', function()
  conform.format()
  vim.defer_fn(vim.cmd.update, 100)
end)
