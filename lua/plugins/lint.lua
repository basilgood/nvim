return {
  'mfussenegger/nvim-lint',
  config = function()
    local augroup = vim.api.nvim_create_augroup('UserConfig', {})
    local autocmd = vim.api.nvim_create_autocmd

    local lint = require('lint')

    local linters = {
      luacheck = {
        prepend_args = { '--globals', 'vim' },
      },
    }
    for name, linter in pairs(linters) do
      if type(linter) == 'table' and type(lint.linters[name]) == 'table' then
        lint.linters[name] = vim.tbl_deep_extend('force', lint.linters[name], linter)
        if type(linter.prepend_args) == 'table' then
          lint.linters[name].args = lint.linters[name].args or {}
          vim.list_extend(lint.linters[name].args, linter.prepend_args)
        end
      else
        lint.linters[name] = linter
      end
    end

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
