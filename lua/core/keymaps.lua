local map = vim.keymap.set

map('n', ']q', ':cnext<cr>')
map('n', '[q', ':cprev<cr>')
map('n', '<C-w>z', [[:wincmd z<bar>cclose<bar>lclose<cr>]], { silent = true })
map('x', 'il', 'g_o^', { silent = true })
map('o', 'il', ':normal vil<cr>', { silent = true })
map('n', '[d', vim.diagnostic.goto_prev)
map('n', ']d', vim.diagnostic.goto_next)
map('n', 'gl', vim.diagnostic.open_float)
