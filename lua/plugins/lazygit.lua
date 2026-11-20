return {
  'zachbuchli/lazygit.nvim',
  cmd = 'Lazygit',
  keys = {
    {
      '<leader>gh',
      function()
        require('lazygit').show()
      end,
    },
  },
}
