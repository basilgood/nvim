return {
  'pmizio/typescript-tools.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'davidosomething/format-ts-errors.nvim',
  },
  config = true,
  opts = {
    settings = {
      expose_as_code_action = {
        'organize_imports',
      },
      tsserver_file_preferences = {
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    handlers = {
      ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
        if result.diagnostics == nil then
          return
        end
        local idx = 1
        while idx <= #result.diagnostics do
          local entry = result.diagnostics[idx]
          local formatter = require('format-ts-errors')[entry.code]
          entry.message = formatter and formatter(entry.message) or entry.message
          idx = idx + 1
        end
        vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
      end,
    },
  },
}
