require('hardline').setup({
  bufferline = false,
  theme = 'one',
  sections = {
    { class = 'mode', item = '%{mode()}', hide = 40 },
    { class = 'high', item = require('hardline.parts.git').get_item, hide = 120 },
    { class = 'med', item = '%{expand("%:p:h:t")}/%t %{&modified?" ":""} %r' },
    '%<',
    { class = 'med', item = '%=' },
    { class = 'error', item = require('hardline.parts.lsp').get_error },
    { class = 'warning', item = require('hardline.parts.lsp').get_warning },
    { class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60 },
    { class = 'mode', item = require('hardline.parts.line').get_item, hide = 60 },
  },
})
