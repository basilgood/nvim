return {
  'L3MON4D3/LuaSnip',
  config = function()
    local ls = require('luasnip')
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node

    ls.add_snippets('lua', {
      s('req', {
        t("require('"),
        i(1),
        t("')"),
        t('.setup({'),
        i(2),
        t('})'),
      }),
    })

    ls.add_snippets('javascript', {
      s('con', {
        t('console.log('),
        i(1),
        t(')'),
      }),
    })

    ls.add_snippets('typescript', {
      s('con', {
        t('console.log('),
        i(1),
        t(')'),
      }),
    })
  end,
}
