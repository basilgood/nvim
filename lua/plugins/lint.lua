return {
  'mfussenegger/nvim-lint',
  config = function()
    local augroup = vim.api.nvim_create_augroup('UserConfig', {})
    local autocmd = vim.api.nvim_create_autocmd

    local lint = require('lint')

    local overrides = {
      luacheck = {
        prepend_args = { '--globals', 'vim' },
      },
    }
    for name, override in pairs(overrides) do
      local upstream = lint.linters[name]
      if type(override) ~= 'table' or type(upstream) ~= 'table' then
        lint.linters[name] = override
      else
        local extra_args = type(override.prepend_args) == 'table' and override.prepend_args or {}
        local args = vim.list_extend(vim.deepcopy(override.args or upstream.args or {}), extra_args)
        lint.linters[name] = vim.tbl_deep_extend('force', upstream, override, { args = args })
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
