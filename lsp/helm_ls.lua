---@type vim.lsp.Config
return {
  settings = {
    ['helm-ls'] = {
      yamlls = {
        enabled = true,
        diagnosticsLimit = 50,
        showDiagnosticsDirectly = false,
        path = 'yaml-language-server',
        config = {
          schemas = {
            kubernetes = 'templates/**',
          },
          completion = true,
          hover = true,
        },
      },
    },
  },
}
