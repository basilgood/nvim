local _border = 'single'

vim.diagnostic.config({
  virtual_text = false,
  underline = false,
  document_highlight = {
    enabled = true,
  },
  capabilities = {
    workspace = {
      fileOperations = {
        didRename = true,
        willRename = true,
      },
    },
  },
  float = {
    border = _border,
    header = '',
    source = true,
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = _border,
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = _border,
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)
