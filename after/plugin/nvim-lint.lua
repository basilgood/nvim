local events = { 'BufWritePost', 'BufReadPost', 'InsertLeave', 'TextChanged', 'DiagnosticChanged' }

local linters_by_ft = {
  lua = { 'luacheck' },
  yaml = { 'yamllint' },
  -- json = { 'jsonlint' },
  -- nix = { 'statix' },
}
local lint = require('lint')
vim.api.nvim_create_autocmd(events, {
  callback = function()
    local linters = linters_by_ft
    local filetype_linters = linters[vim.bo.filetype]
    if filetype_linters then
      for _, linter in pairs(filetype_linters) do
        local executable = io.popen('which ' .. linter .. ' > /dev/null 2>&1; echo $?', 'r'):read('*l')
        if executable == '0' then
          lint.try_lint(linter)
        else
          vim.notify('Linter ' .. linter .. ' not found or not executable', vim.log.levels.WARN)
        end
      end
    end
  end,
})
