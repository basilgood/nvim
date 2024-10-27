local cmp = require('cmp')
local snippy = require('snippy')
local lspkind = require('lspkind')
local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end
local select_opts = { behavior = cmp.SelectBehavior.Select }
local replace_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }

cmp.setup({
  snippet = {
    expand = function(args)
      snippy.expand_snippet(args.body)
    end,
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ['<up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<down>'] = cmp.mapping.select_next_item(select_opts),
    ['<cr>'] = cmp.mapping.confirm(replace_opts),
    ['<c-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif snippy.can_expand_or_advance() then
        snippy.expand_or_advance()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif snippy.can_jump(-1) then
        snippy.previous()
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'snippy', keyword_length = 2 },
    { name = 'nvim_lsp' },
    { name = 'buffer', keyword_length = 3 },
    { name = 'async_path' },
    { name = 'nvim_lsp_signature_help' },
  },
  window = {
    completion = {
      winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
      col_offset = -3,
      side_padding = 0,
    },
  },
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      local item = lspkind.cmp_format({ preset = 'codicons', mode = 'symbol_text', maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(item.kind, '%s', { trimempty = true })

      item.kind = ' ' .. strings[1] .. ' '
      item.abbr = string.gsub(item.abbr, '^%s', '')

      return item
    end,
  }
})
