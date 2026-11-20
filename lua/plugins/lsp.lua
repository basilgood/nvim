return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'antonk52/filepaths_ls.nvim',
    'qvalentin/helm-ls.nvim',
    'b0o/SchemaStore.nvim',
  },
  config = function()
    require('helm-ls').setup({
      indent_hints = {
        enable = true,
        filter = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          return ft == 'helm' or ft == 'yaml' or ft:match('yaml')
        end,
      },
    })

    vim.lsp.enable({
      'lua_ls',
      'vtsls',
      'bashls',
      'cssls',
      'nixd',
      'gopls',
      'dockerls',
      'rust_analyzer',
      'yamlls',
      'helm_ls',
      'filepaths_ls',
      'org',
      'harper',
    })
  end,
}
