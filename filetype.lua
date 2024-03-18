vim.filetype.add({
  extension = {
    conf = 'config',
    njk = 'htmldjango',
    ['tsconfig*.json'] = 'jsonc',
  },
  filename = {
    ['.luacheckrc'] = 'lua',
    ['.eslintrc.json'] = 'jsonc',
    ['.envrc'] = 'config',
  },
})
