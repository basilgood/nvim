---@type vim.lsp.Config
return {
  capabilities = {
    textDocument = {
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
  before_init = function(_, config)
    config.settings.yaml.schemas =
      vim.tbl_deep_extend('force', config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      keyOrdering = false,
      format = {
        enable = true,
        singleQuote = true,
      },
      validate = true,
      schemaStore = {
        enable = false,
        url = '',
      },
    },
  },
}
