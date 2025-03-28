local conform = require('conform')
conform.setup({
  formatters = {
    shfmt = {
      inherit = false,
      command = 'shfmt',
      args = { '-i', '2', '-ci', '-filename', '$FILENAME' },
    },
  },
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    html = { 'prettier' },
    css = { 'prettier' },
    yaml = { 'prettier' },
    nix = { 'alejandra' },
    rust = { 'rustfmt' },
    sh = { 'shfmt' },
    json = { 'fixjson' },
    jsonc = { 'fixjson' },
  },
})
vim.keymap.set({ 'n', 'v' }, 'Q', function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
  vim.schedule(function()
    vim.cmd('update')
  end)
end)
