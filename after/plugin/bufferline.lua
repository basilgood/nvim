require('bufferline').setup({
  options = {
    mode = 'tabs',
    enforce_regular_tabs = true,
    always_show_bufferline = false,
  },
})
vim.keymap.set('n', '<leader><leader>', '<cmd>BufferLinePick<cr>')
