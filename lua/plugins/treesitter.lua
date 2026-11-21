return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    -- stylua: ignore
    require('nvim-treesitter').install {
      'astro', 'bash', 'c', 'comment', 'cpp', 'css', 'csv', 'diff',
      'dockerfile', 'git_config', 'gitcommit', 'gitattributes', 'git_rebase',
      'gitignore', 'go', 'helm', 'html', 'hyprlang',
      'http', 'javascript', 'jsx', 'jsdoc', 'json', 'json5', 'tsx', 'lua',
      'markdown', 'markdown_inline', 'nix', 'regex', 'rust', 'scss',
      'styled', 'terraform', 'toml', 'typescript', 'vim', 'vimdoc', 'yaml',
    }
    local augroup = vim.api.nvim_create_augroup('nvim_treesitter', {})
    vim.api.nvim_create_autocmd('FileType', {
      group = augroup,
      desc = 'Start tree-sitter highlighting for the buffer',
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
