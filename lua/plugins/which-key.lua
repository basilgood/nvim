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
      { '<leader>s', group = 'Surround' },
      { '<leader>g', group = 'Git' },
    })
  end,
}
