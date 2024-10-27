local persistence = require('persistence')
local map = vim.keymap.set

persistence.setup({
  options = vim.opt.sessionoptions:get(),
})

map('n', '<leader>s', function()
  persistence.load()
end)
