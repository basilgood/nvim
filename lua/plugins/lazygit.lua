return {
  'zachbuchli/lazygit.nvim',
  config = function()
    local lazygit = require('lazygit')
    vim.keymap.set('n', '<leader>gh', lazygit.show)
  end,
}
