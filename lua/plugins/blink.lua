return {
  'saghen/blink.cmp',
  version = vim.version.range('^1'),
  event = 'InsertEnter',
  opts = {
    keymap = { preset = 'enter' },
    cmdline = { enabled = false },
    completion = {
      accept = { auto_brackets = { enabled = false } },
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      menu = {
        draw = { columns = { { 'label' }, { 'kind_icon' } } },
        scrolloff = 1,
        scrollbar = false,
      },
      list = { selection = { preselect = true, auto_insert = false } },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
}
