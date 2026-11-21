-- Neovim's own message UI: short messages in a corner popup, long output in a
-- pager, command-line traffic stays in the command line.
local function enable_ui2_messages()
  require('vim._core.ui2').enable({
    enable = true,
    msg = {
      targets = {
        default = 'msg',
        typed_cmd = 'cmd',
        -- Long output goes to the pager.
        emsg = 'pager',
        echoerr = 'pager',
        lua_error = 'pager',
        rpc_error = 'pager',
        list_cmd = 'pager',
        verbose = 'pager',
        shell_cmd = 'pager',
        shell_out = 'pager',
        shell_err = 'pager',
        shell_ret = 'pager',
        progress = 'pager',
        -- These stay in the command line.
        search_count = 'cmd',
        search_cmd = 'cmd',
        completion = 'cmd',
        wildlist = 'cmd',
        confirm = 'cmd',
      },
      dialog = { height = 0.5 },
      msg = { height = 0.3 },
      pager = { height = 0.5 },
    },
  })
end

return {
  'basilgood/nvim-sensible',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      formatexpr = 'v:lua.require("conform").formatexpr()',
      diffopt = { append = 'inline:char' },
      guicursor = 'n-v-c:block-Cursor,i:block-CursorInsert',
      cmdheight = 0,
      messagesopt = { append = { 'pager:<CR>', 'timeout:5000' } },
    },
  },
  config = function(_, opts)
    require('sensible').setup(opts)
    enable_ui2_messages()
  end,
}
