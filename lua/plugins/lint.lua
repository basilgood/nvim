return {
  'mfussenegger/nvim-lint',
  config = function()
    local autocmd = vim.api.nvim_create_autocmd

    require('lint').linters_by_ft = {
      lua = { 'luacheck' },
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      yaml = { 'yamllint' },
      json = { 'jsonlint' },
    }

    autocmd({ 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged' }, {
      callback = function()
        require('lint').try_lint()
      end,
    })
  end,
}
