local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

map('n', '-', function()
  local file = vim.fn.expand('%:t')
  vim.cmd('Explore')
  vim.fn.search('^' .. file .. '$', 'wc')
end)

autocmd('filetype', {
  pattern = 'netrw',
  callback = function()
    local opts = { buffer = true, remap = true }
    map('n', '<tab>', 'mf', opts)
    map('n', '<esc>', 'mF', opts)
    map('n', '.', 'mfmx', opts)
    map('n', 'P', '<cmd>wincmd w|bd|wincmd c<cr>', opts)
  end,
})
