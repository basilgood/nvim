require('blink.cmp').setup({
  keymap = {
    preset = 'enter',
    ['<c-l>'] = { 'show', 'show_documentation', 'hide_documentation' },
    ['<Tab>'] = { 'snippet_forward', 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'select_prev', 'fallback' },
  },
  completion = {
    list = {
      selection = {
        auto_insert = false,
        preselect = true,
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})
