vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.pack.add({ 'https://github.com/zuqini/zpack.nvim' }, { confirm = false })

require('zpack').setup({
  defaults = {
    confirm = false,
  },
  cmd_name = 'Z',
})
