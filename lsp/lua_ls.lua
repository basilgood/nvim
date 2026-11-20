---@type vim.lsp.Config
return {
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
}
