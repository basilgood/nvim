return {
  {
    'nvimdev/hlsearch.nvim',
    event = 'BufReadPre',
    opts = {},
  },

  {
    'numToStr/Comment.nvim',
    event = 'BufReadPre',
    opts = { ignore = '^$' },
  },

  {
    'kylechui/nvim-surround',
    event = 'BufReadPre',
    opts = {},
  },

  {
    'echasnovski/mini.bufremove',
    config = function()
      vim.keymap.set('n', '<c-w>d', function()
        require('mini.bufremove').delete(0, false)
      end)
    end,
  },

  {
    'echasnovski/mini.indentscope',
    opts = { draw = { delay = 2000 }, symbol = '│' },
  },

  {
    'basilgood/pounce.nvim',
    opts = {
      accept_keys = 'jfkdlsahgnuvrbytmiceoxwpqz',
    },
    keys = {
      { 's', '<cmd>Pounce<cr>' },
      { 'S', '<cmd>PounceRepeat<cr>' },
    },
  },

  {
    'linjiX/vim-star',
    keys = {
      { '*', '<Plug>(star-*)', mode = { 'n', 'x' } },
      { 'gs', '<Plug>(star-*)cgn', mode = { 'n', 'x' } },
    },
  },

  {
    'Jxstxs/conceal.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  'stevearc/dressing.nvim',
  'kkoomen/gfi.vim',
  'LunarVim/bigfile.nvim',
}
