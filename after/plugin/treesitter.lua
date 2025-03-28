vim.cmd([[
  let g:gindent = {}
  let g:gindent.enabled = { -> index(['javascript', 'typescript', 'lua'], &filetype) != -1 }
]])

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'comment',
    'csv',
    'diff',
    'gitcommit',
    'git_rebase',
    'go',
    'javascript',
    'jsdoc',
    'json',
    'jsonc',
    'html',
    'http',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'regex',
    'rust',
    'scss',
    'styled',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
    'cpp',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = 'v',
      node_decremental = 'V',
      scope_incremental = false,
    },
  },
})
