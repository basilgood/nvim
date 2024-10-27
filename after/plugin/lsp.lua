local map = vim.keymap.set
local lspconfig = require('lspconfig')
require('diagflow').setup({ scope = 'line' })

local function organize_imports()
  local params = {
    command = '_typescript.organizeImports',
    arguments = { vim.api.nvim_buf_get_name(0) },
    title = '',
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig['ts_ls'].setup({
  on_attach = function(client, bufnr)
    require('twoslash-queries').attach(client, bufnr)
  end,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = 'Organize Imports',
    },
  },
})
lspconfig.eslint.setup({})
lspconfig.jsonls.setup({})
lspconfig.nil_ls.setup({})
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
        },
        checkThirdParty = false,
      },
    },
  },
})

map('i', '<c-k>', vim.lsp.buf.signature_help, { desc = 'show signature' })
map({ 'v', 'n' }, '<f4>', require('actions-preview').code_actions)
map('n', '<f2>', require('live-rename').rename)
