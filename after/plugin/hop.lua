local map = vim.keymap.set
local hop = require('hop')
hop.setup({ keys = 'etovxqpdygfblzhckisuran' })
map('n', 's', '<cmd>HopChar1<cr>')
map('', 'f', '<cmd>HopChar1CurrentLine<cr>')
