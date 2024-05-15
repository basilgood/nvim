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
    'smjonas/inc-rename.nvim',
    config = function()
      require('inc_rename').setup({ input_buffer_type = 'dressing', save_in_cmdline_history = false })
      vim.keymap.set('n', '<f2>', function()
        return ':IncRename ' .. vim.fn.expand('<cword>')
      end, { expr = true })
    end,
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

  {
    'otavioschwanck/arrow.nvim',
    event = 'VeryLazy',
    opts = {
      show_icons = true,
      leader_key = 'm',
    },
  },

  {
    'NStefan002/screenkey.nvim',
    cmd = 'Screenkey',
    config = true,
  },

  {
    'Lenovsky/nuake',
    keys = {
      { '<f3>', '<cmd>Nuake<cr>' },
      { '<f3>', '<C-\\><C-n><cmd>Nuake<cr>', mode = { 'i', 't' } },
      { '<esc>', '<C-\\><C-n>', mode = { 't' } },
    },
  },

  {
    'smjonas/live-command.nvim',
    config = function()
      require('live-command').setup({
        commands = {
          Norm = { cmd = 'norm' },
        },
      })
    end,
  },

  {
    'stevearc/dressing.nvim',
    opts = {},
  },
  'mg979/vim-visual-multi',
  'kkoomen/gfi.vim',
  'LunarVim/bigfile.nvim',
}
