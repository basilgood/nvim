return {
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      nix = { 'alejandra' },
      rust = { 'rustfmt' },
      sh = { 'shfmt' },
      yaml = { 'prettier' },
      json = { 'jq' },
      jsonc = { 'jq' },
    },
  },
  keys = {
    {
      'Q',
      function()
        require('conform').format()
        vim.cmd.update()
      end,
    },
  },
}
