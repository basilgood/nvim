local map = vim.keymap.set

-- bufremove
map('n', '<c-w>d', function()
  require('mini.bufremove').delete(0, false)
end)

-- star
require('star').setup({ auto_map = false })

map({ 'n', 'x' }, '*', function()
  require('star').star('star')
end)
map({ 'n', 'x' }, 'gs', function()
  require('star').star('star')
  vim.api.nvim_feedkeys('cgn', 'nt', true)
end)
