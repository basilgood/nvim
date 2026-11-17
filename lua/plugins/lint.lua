return {
  'mfussenegger/nvim-lint',
  config = function()
    local augroup = vim.api.nvim_create_augroup('UserConfig', {})
    local autocmd = vim.api.nvim_create_autocmd

    local lint = require('lint')

    local upstream = lint.linters.luacheck
    local args = vim.list_extend(vim.deepcopy(upstream.args or {}), { '--globals', 'vim' })
    lint.linters.luacheck = vim.tbl_deep_extend('force', upstream, { args = args })

    lint.linters_by_ft = {
      lua = { 'luacheck' },
      bash = { 'shellcheck' },
      sh = { 'shellcheck' },
      json = { 'jq' },
      dockerfile = { 'hadolint' },
    }

    autocmd({ 'BufEnter', 'BufWritePost', 'TextChanged', 'InsertLeave' }, {
      group = augroup,
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
  end,
}
