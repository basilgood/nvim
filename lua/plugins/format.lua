vim.g.autoformat = true

return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup({
      notify_no_formatters = false,
      formatters = {
        dockerfmt = {
          command = 'dockerfmt',
          args = { '-i', '4' },
        },
      },
      formatters_by_ft = {
        c = { name = 'clangd', lsp_format = 'prefer' },
        dockerfile = { 'dockerfmt' },
        go = { name = 'gopls', lsp_format = 'prefer' },
        javascript = { 'prettier', lsp_format = 'fallback' },
        json = { 'prettier', 'jq', stop_after_first = true, lsp_format = 'fallback' },
        jsonc = { 'prettier', lsp_format = 'fallback' },
        less = { 'prettier' },
        lua = { 'stylua' },
        markdown = { 'prettier' },
        rust = { name = 'rust_analyzer', lsp_format = 'prefer' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        nix = { 'nixfmt' },
        typescript = { 'prettier', lsp_format = 'fallback' },
        yaml = { name = 'yamlls', lsp_format = 'prefer' },
        ['_'] = { 'trim_whitespace', 'trim_newlines' },
      },
      format_on_save = function()
        if vim.g.skip_formatting or not vim.g.autoformat then
          return nil
        end
        return {}
      end,
    })
  end,
}
