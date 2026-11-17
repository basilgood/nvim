return {
  {
    'bytebeast/kissaten.nvim',
    lazy = false,
    priority = 1000,
    -- version = "*", -- uncomment to stay on tagged releases
    opts = {
      -- Styles: "morning" (light) | "afternoon" | "evening" | "midnight"
      style = 'evening', -- dark style used by `colorscheme kissaten`
      light_style = 'morning', -- used when vim.o.background == "light"

      transparent = false, -- true: don't paint the background (terminal blur, tmux)
      terminal_colors = true, -- theme the colors of :terminal
      dim_inactive = false, -- true: darken windows you're not working in

      -- "normal" | "high" (brighter comments, line numbers and UI hints)
      contrast = 'normal',

      -- Let comments fade behind the code:
      --   false                 off (comments at ~4.5:1 contrast)
      --   true or 0.5           gently faded (~3:1)
      --   { fade = 0.7 }        clearly faded (~2.5:1); 0 = off, 1 = faintest (1.6:1)
      --   { fade = 0.7, docstrings = false }  fade comments, keep docstrings
      subtle_comments = false,

      -- Text attributes per category. Use any of:
      -- italic, bold, underline, undercurl, strikethrough, reverse
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {}, -- e.g. { bold = true }
        variables = {},
        parameters = {}, -- e.g. { italic = true }
        types = {},
        strings = {},
        constants = {},
        -- Backgrounds: "dark" | "normal" | "transparent"
        sidebars = 'dark', -- file explorer, trouble, outline, ...
        floats = 'dark', -- pickers, hover docs, popups
      },

      -- Global switches that win over everything above
      no_italic = false, -- true for fonts without italics
      no_bold = false,
      no_underline = false,

      bright_borders = false, -- true: accent-colored float borders
      lualine_bold = false, -- true: bold mode section in the statusline

      -- Recolor anything (see README "Overrides and recipes"):
      -- on_colors = function(c) c.syn.parameter = c.yellow end,
      -- on_highlights = function(hl, c) hl.CursorLineNr = { fg = c.orange, bold = true } end,
    },
    config = function()
      vim.cmd.colorscheme('kissaten')
    end,
  },
  -- {
  --   'catppuccin/nvim',
  --   name = 'catppuccin',
  --   lazy = false,
  --   config = function()
  --     require('catppuccin').setup({
  --       flavour = 'mocha',
  --       custom_highlights = function()
  --         return {
  --           NormalFloat = { link = 'Normal' },
  --         }
  --       end,
  --     })
  --     vim.cmd.colorscheme('catppuccin')
  --   end,
  -- },
  -- {
  --   'oxidescheme/nvim',
  --   name = 'oxide',
  --   lazy = false,
  --   priority = 1000,
  --   config = function()
  --     require('oxide').setup()
  --     vim.cmd.colorscheme('oxide')
  --   end,
  -- },
}
-- return {
--   {
--     'folke/tokyonight.nvim',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require('tokyonight').setup({
--         style = 'moon',
--         styles = {
--           keywords = { italic = false },
--           comments = { italic = false },
--         },
--         on_highlights = function(hl, c)
--           hl.DiffDelete = { bg = c.diff.delete, fg = c.diff.delete }
--           hl.GitSignsDeletePreview = { bg = c.diff.delete }
--           hl.GitSignsDeleteVirtLn = { bg = c.diff.delete }
--           hl.GitSignsVirtLnum = { bg = c.diff.delete }
--         end,
--       })
--       -- vim.cmd.colorscheme('tokyonight')
--     end,
--   },
--   {
--     'oskarnurm/koda.nvim',
--     lazy = false, -- make sure we load this during startup if it is your main colorscheme
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--       require('koda').setup({
--         on_highlights = function(hl)
--           hl.CurSearch = vim.deepcopy(hl.DiffChange or {})
--           hl.Substitute = vim.deepcopy(hl.DiffAdd or {})
--           for _, name in ipairs({ 'DiffAdd', 'DiffChange', 'DiffText' }) do
--             local group = hl[name]
--             if type(group) == 'table' and group.bg then
--               hl[name] = { bg = group.bg }
--             end
--           end
--           local del_bg = type(hl.DiffDelete) == 'table' and hl.DiffDelete.bg
--           if del_bg then
--             -- hl.DiffDelete = { bg = del_bg, fg = del_bg }
--             hl.GitSignsDeletePreview = { bg = del_bg }
--             hl.GitSignsDeleteVirtLn = { bg = del_bg }
--             hl.GitSignsVirtLnum = { bg = del_bg }
--           end
--         end,
--       })
--       -- vim.cmd('colorscheme koda-moss')
--     end,
--   },
--   -- Using lazy.nvim
--   {
--     'bluz71/vim-moonfly-colors',
--     name = 'moonfly',
--     lazy = false,
--     priority = 1000,
--     config = function()
--       vim.cmd('colorscheme moonfly')
--     end,
--   },
-- }
