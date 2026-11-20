local map = vim.keymap.set

-- Save without formatting
map('n', '<C-s>', function()
  vim.g.skip_formatting = true
  vim.cmd('noautocmd write')
  vim.notify('Formatting skipped for this save', vim.log.levels.INFO)
  -- Reset flag after save
  vim.defer_fn(function()
    vim.g.skip_formatting = false
  end, 100)
end, { desc = 'Save without formatting' })

map('n', '<M-S-O>', ':bprev<CR>', { desc = 'Previous buffer' })
map('n', '<M-S-I>', ':bnext<CR>', { desc = 'Next buffer' })

map('n', '<leader>.', function()
  local hide = vim.wo.number or vim.wo.signcolumn == 'yes'
  vim.wo.number = not hide
  vim.wo.relativenumber = not hide
  vim.wo.signcolumn = hide and 'no' or 'yes'
end, { desc = 'Toggle gutter' })

map('n', '<leader>,', function()
  vim.o.mouse = vim.o.mouse == 'a' and '' or 'a'
end, { desc = 'Toggle mouse' })

map('n', '<leader><tab>', function()
  vim.cmd([[tab split]])
end, { desc = 'Buffer full-screen' })
