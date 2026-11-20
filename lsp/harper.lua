---@type vim.lsp.Config
return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown', 'text', 'tex', 'typst' },
}
