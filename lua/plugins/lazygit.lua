return {
  'zachbuchli/lazygit.nvim',
  keys = {
    {
      '<leader>gh',
      function()
        require('lazygit').show()
      end,
    },
  },
}
