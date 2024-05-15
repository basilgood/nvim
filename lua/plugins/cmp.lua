return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'FelipeLema/cmp-async-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'onsails/lspkind.nvim',
  },
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local luasnip = require('luasnip')
    local select_opts = { behavior = cmp.SelectBehavior.Select }
    local replace_opts = { behavior = cmp.ConfirmBehavior.Replace, select = false }

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = 'single',
          winhighlight = 'Normal:NormalFloat,CursorLine:Visual,Search:None',
          col_offset = 0,
          side_padding = 0,
        },
        documentation = {
          border = 'single',
          winhighlight = 'Normal:NormalFloat,CursorLine:Visual,Search:None',
        },
      },
      mapping = {
        ['<up>'] = cmp.mapping.select_prev_item(select_opts),
        ['<down>'] = cmp.mapping.select_next_item(select_opts),
        ['<cr>'] = cmp.mapping.confirm(replace_opts),
        ['<c-e>'] = cmp.mapping.abort(),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'async_path' },
        { name = 'nvim_lsp_signature_help' },
      },
      formatting = {
        format = function(_, item)
          item.kind = lspkind.presets.codicons[item.kind] .. ' ' .. item.kind
          item.abbr = item.abbr:match('[^(]+')

          return item
        end,
      },
    })
  end,
}
