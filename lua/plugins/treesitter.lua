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
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
