return {
  'basilgood/truffle.nvim',
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

    vim.keymap.set('n', '<leader>th', function()
      require('truffle').switch_profile('hax')
    end, { desc = 'Truffle: hax profile' })
    vim.keymap.set('n', '<leader>tz', function()
      require('truffle').switch_profile('zaly')
    end, { desc = 'Truffle: zaly profile' })
  end,
}
