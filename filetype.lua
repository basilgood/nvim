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
    -- Neovim already detects .luacheckrc as lua; listed on purpose so the
    -- mapping does not depend on that builtin staying in place.
    ['.luacheckrc'] = 'lua',
    ['.envrc'] = 'config',
  },
})
