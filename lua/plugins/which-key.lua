return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()
    local wk = require('which-key')

    wk.setup({
      preset = 'helix',
      delay = 300,
      icons = {
        mappings = false,
        separator = '',
        keys = {
          Up = '↑',
          Down = '↓',
          Left = '←',
          Right = '→',
          C = 'C-',
          M = 'M-',
          D = 'D-',
          S = 'S-',
          CR = '⏎',
          Esc = 'Esc',
          ScrollWheelDown = '↓',
          ScrollWheelUp = '↑',
          NL = '⏎',
          BS = '⌫',
          Space = '␣',
          Tab = '⇥',
        },
      },
    })

    wk.add({
      { '<leader>q', group = 'Quickfix' },
      { '<leader>s', group = 'Session & Scratch' },
      { '<leader>g', group = 'Git' },
      { '<leader>b', group = 'Buffers' },
      { '<M-S-O>', ':bprev<CR>', desc = 'Previous buffer' },
      { '<M-S-I>', ':bnext<CR>', desc = 'Next buffer' },
      {
        '<leader>.',
        function()
          local hide = vim.wo.number or vim.wo.signcolumn == 'yes'
          vim.wo.number = not hide
          vim.wo.relativenumber = not hide
          vim.wo.signcolumn = hide and 'no' or 'yes'
        end,
        desc = 'Toggle gutter',
      },
      {
        '<leader>,',
        function()
          vim.o.mouse = vim.o.mouse == 'a' and '' or 'a'
        end,
        desc = 'Toggle mouse',
      },
      {
        '<leader><tab>',
        function()
          vim.cmd([[tab split]])
        end,
        desc = 'Buffer full-screen',
      },
    })
  end,
}
