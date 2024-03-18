return {
  'nvim-treesitter/nvim-treesitter',
  dependencies = {
    'yioneko/nvim-yati',
    'HiPhish/rainbow-delimiters.nvim',
  },
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        'astro',
        'bash',
        'css',
        'comment',
        'csv',
        'diff',
        'gitcommit',
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
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      yati = {
        enable = true,
        default_fallback = 'auto',
        suppress_conflict_warning = true,
      },
      indent = {
        enable = true,
        disable = { 'javascript', 'typescript', 'html', 'rust', 'lua', 'css', 'tsx', 'json', 'toml' },
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
  end,
}
