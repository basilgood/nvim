local map = vim.keymap.set
local command = vim.api.nvim_create_user_command

local capabilities = require('blink.cmp').get_lsp_capabilities()
local lspconfig = require('lspconfig')

-- typescript ^?
require('twoslash-queries').setup({
  highlight = 'Comment',
  multi_line = true,
})

require('lspconfig.configs').vtsls = require('vtsls').lspconfig
lspconfig.vtsls.setup({
  on_attach = function(client, bufnr)
    require('twoslash-queries').attach(client, bufnr)
    command('OrganizeImports', function()
      require('vtsls').commands.organize_imports(bufnr)
    end, { desc = 'Organize Imports' })
  end,
  capabilities = capabilities,
})
lspconfig.eslint.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.nixd.setup({ offset_encoding = 'utf-8', capabilities = capabilities })
lspconfig.clangd.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
  capabilities = capabilities,
})
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim' },
        disable = {
          'missing-fields',
          'no-unknown',
        },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
          '${3rd}/luv/library',
        },
        checkThirdParty = false,
      },
    },
  },
  capabilities = capabilities,
})

map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
map('n', '<f4>', vim.lsp.buf.code_action)

map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
map({ 'v', 'n' }, '<f4>', require('actions-preview').code_actions)
map('n', '<f2>', require('live-rename').rename)
