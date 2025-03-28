local map = vim.keymap.set

map('n', ']q', ':cnext<cr>')
map('n', '[q', ':cprev<cr>')
map('n', ']l', ':lnext<cr>')
map('n', '[l', ':lprev<cr>')
map('x', 'il', 'g_o^', { silent = true })
map('o', 'il', ':normal vil<cr>', { silent = true })
map({ 'n', 'x' }, 'j', 'gj')
map({ 'n', 'x' }, 'k', 'gk')
map({ 'n', 'x' }, '<down>', 'gj')
map({ 'n', 'x' }, '<up>', 'gk')
