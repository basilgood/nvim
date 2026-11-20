return {
  'basilgood/truffle.nvim',
  lazy = false,
  config = function()
    require('truffle').setup({
      mappings = {
        next_profile = '<leader>tn',
        prev_profile = '<leader>tp',
      },
      profiles = {
        hax = {
          command = 'hax',
          default = true,
        },
        zaly = {
          command = 'zaly',
          args = { '-n' },
        },
      },
    })
  end,
  keys = {
    {
      '<leader>th',
      function()
        require('truffle').switch_profile('hax')
      end,
      desc = 'Truffle: hax profile',
    },
    {
      '<leader>tz',
      function()
        require('truffle').switch_profile('zaly')
      end,
      desc = 'Truffle: zaly profile',
    },
  },
}
