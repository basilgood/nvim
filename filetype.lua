vim.filetype.add({
  extension = {
    conf = 'config',
    har = 'json',
    njk = 'htmldjango',
  },
  filename = {
    ['.eslintrc'] = 'json',
    ['tsconfig.json'] = 'json',
    ['tsconfig.build.json'] = 'json',
    ['.luacheckrc'] = 'lua',
    ['.envrc'] = 'config',
  },
})
