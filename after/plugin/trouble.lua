local map = vim.keymap.set

require('trouble').setup()

map('n', '<leader>d', '<cmd>Trouble diagnostics focus<cr>')
map('n', 'gd', '<cmd>Trouble lsp_definitions focus<cr>')
map('n', 'gD', '<cmd>Trouble lsp_type_definitions focus<cr>')
map('n', 'gr', '<cmd>Trouble lsp_references focus<cr>')
map('n', 'gy', '<cmd>Trouble lsp_implementations focus<cr>')
