return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'antonk52/filepaths_ls.nvim',
    'qvalentin/helm-ls.nvim',
    'b0o/SchemaStore.nvim',
  },
  config = function()
    require('helm-ls').setup({
      indent_hints = {
        enable = true,
        filter = function(bufnr)
          local ft = vim.bo[bufnr].filetype
          return ft == 'helm' or ft:match('yaml')
        end,
      },
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          completion = { callSnippet = 'Replace', workspaceWord = false },
          format = { enable = false },
          hint = {
            enable = true,
            arrayIndex = 'Disable',
          },
          runtime = {
            version = 'LuaJIT',
          },
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              '${3rd}/luv/library',
            },
          },
        },
      },
    })

    vim.lsp.config('vtsls', {
      settings = {
        vtsls = { autoUseWorkspaceTsdk = true },
      },
    })

    vim.lsp.config('rust_analyzer', {
      settings = {
        ['rust-analyzer'] = {
          check = {
            command = 'clippy',
          },
        },
      },
    })

    vim.lsp.config('yamlls', {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
          },
        },
      },
      before_init = function(_, config)
        config.settings.yaml.schemas =
          vim.tbl_deep_extend('force', config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
      end,
      settings = {
        redhat = { telemetry = { enabled = false } },
        yaml = {
          keyOrdering = false,
          format = {
            enable = true,
            singleQuote = true,
          },
          validate = true,
          schemaStore = {
            enable = false,
            url = '',
          },
        },
      },
    })

    vim.lsp.config('helm_ls', {
      settings = {
        ['helm-ls'] = {
          yamlls = {
            enabled = true,
            diagnosticsLimit = 50,
            showDiagnosticsDirectly = false,
            path = 'yaml-language-server',
            config = {
              schemas = {
                kubernetes = 'templates/**',
              },
              completion = true,
              hover = true,
            },
          },
        },
      },
    })

    vim.lsp.config('harper', {
      cmd = { 'harper-ls', '--stdio' },
      filetypes = { 'markdown', 'text', 'tex', 'typst' },
    })

    vim.lsp.enable({
      'lua_ls',
      'vtsls',
      'bashls',
      'cssls',
      'nixd',
      'gopls',
      'dockerls',
      'rust_analyzer',
      'yamlls',
      'helm_ls',
      'filepaths_ls',
      'org',
      'harper',
    })
  end,
}
