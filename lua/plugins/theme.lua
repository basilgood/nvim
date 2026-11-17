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
}
