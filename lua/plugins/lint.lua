return {
  'mfussenegger/nvim-lint',
  config = function()
    local autocmd = vim.api.nvim_create_autocmd

    require('lint').linters_by_ft = {
      lua = { 'luacheck' },
      nix = { 'statix' },
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
    }

    autocmd({ 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      command = 'silent! lua require("lint").try_lint()',
    })
  end,
}
