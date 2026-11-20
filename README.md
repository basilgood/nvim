# nvim

A personal Neovim configuration, meant to be cloned as Neovim's config directory and used as-is.

The config runs on Neovim's built-in package manager, `vim.pack`. `init.lua` bootstraps [zpack.nvim](https://github.com/zuqini/zpack.nvim), which imports every spec in `lua/plugins/` and installs missing plugins without prompting. Specs use the lazy.nvim-style format (`event`, `cmd`, `keys`, `opts`, `config`). Installed revisions are pinned in `nvim-pack-lock.json`.

## Requirements

- Neovim 0.12 or newer. The config calls `vim.pack` and enables `vim._core.ui2`.
- `git`, which `vim.pack` uses to fetch plugins.
- Tools that the config invokes but does not install. Put the ones you need on `PATH`:
  - Language servers enabled in `lua/plugins/lsp.lua`: `lua_ls`, `vtsls`, `bashls`, `cssls`, `nixd`, `gopls`, `dockerls`, `rust_analyzer`, `yamlls`, `helm_ls`, `filepaths_ls`, `org`, `harper`.
  - Formatters used by conform in `lua/plugins/format.lua`: `stylua`, `prettier`, `shfmt`, `nixfmt`, `dockerfmt`, `jq`. Go, Rust and YAML are formatted through their language server.
  - Linters used by nvim-lint in `lua/plugins/lint.lua`: `luacheck`, `shellcheck`, `jq`, `hadolint`.
  - Other binaries named in plugin configs: `lazygit`, `npm` (markdown-preview build), `tmux` (prompt-reference sink), `hax` and `zaly` (truffle profiles).

## Install

Clone the repository to Neovim's config directory and start Neovim:

```sh
git clone https://github.com/basilgood/nvim ~/.config/nvim
nvim
```

The first start adds zpack.nvim, then installs every plugin declared under `lua/plugins/`. Confirmation prompts are disabled in `init.lua`. A plugin's build hook runs in the same session that zpack installs or updates it.

Plugin management is the `:Z` command, named in `init.lua`. Its subcommands include `update`, `restore`, `clean`, `build`, `load`, `delete`, `sync` and `reload`. `:Z restore` returns plugins to the revisions in `nvim-pack-lock.json`.

## Layout

```text
init.lua              entry point: leader keys, zpack bootstrap, keymap loading
lua/config/*.lua      global config modules, required explicitly
lua/plugins/*.lua     plugin specs, one file per area, imported automatically by zpack
lsp/*.lua             language server settings, loaded by vim.lsp.enable
after/queries/ecma/   extra tree-sitter injection queries
filetype.lua          extra filetype mappings
nvim-pack-lock.json   locked plugin revisions
stylua.toml           Lua formatting style for this repository
```

- `init.lua` sets `mapleader` to space and `maplocalleader` to `\`, adds zpack.nvim with `vim.pack.add`, calls `require('zpack').setup` with `defaults.confirm = false` and `cmd_name = 'Z'`, then loads `lua/config/keymaps.lua`.
- `lua/plugins/` holds the configuration proper. Each file returns one spec or a list, for example `lsp.lua`, `format.lua`, `lint.lua`, `treesitter.lua`, `editor.lua`, `keymaps.lua`, `theme.lua`, `ui.lua`, `git.lua` and `fzf.lua`. zpack's default import reads this directory, so a new file needs no registration.
- `after/queries/ecma/injections.scm` extends the ECMAScript queries to highlight HTML inside template strings and CSS inside `style` template strings.
- `filetype.lua` maps extensions (`conf`, `har`, `njk`) and filenames (`.eslintrc`, `tsconfig.json`, `tsconfig.build.json`, `.luacheckrc`, `.envrc`) to filetypes.
- `nvim-pack-lock.json` is written by the package manager and records each plugin's `src` and `rev`.
- `stylua.toml` sets the Lua style used in the repo: two-space indent, 120 columns, single quotes, Unix line endings.

Supporting files: `.luacheckrc` and `.luarc.json` configure Lua linting and `lua_ls`; `.editorconfig` sets editor defaults; `AGENTS.md` holds instructions for coding agents.

## Where to change things

- Startup, leader keys and plugin-manager options: `init.lua`.
- A plugin's options or config: the matching file in `lua/plugins/`, such as completion in `blink.lua`, pickers and the explorer in `fzf.lua`, or the colorscheme in `theme.lua`.
- Neovim defaults and `ui2` message routing: `lua/plugins/sensible.lua`.
- Language server settings: `lsp/*.lua`, one file per server. `lua/plugins/lsp.lua` enables them through `vim.lsp.enable`.
- Formatting: `lua/plugins/format.lua`. `vim.g.autoformat` at the top switches format-on-save, and `<C-s>` writes the current buffer without formatting.
- Linting: `lua/plugins/lint.lua`, including `lint.linters_by_ft`.
- Keymaps: `lua/config/keymaps.lua` for global maps, `lua/plugins/keymaps.lua` for `mini.keymap` behaviour, plus maps defined next to their plugin. Which-key groups and labels are in `lua/plugins/which-key.lua`.
- Filetype detection: `filetype.lua`.
- Tree-sitter injections: `after/queries/`.
- Plugin versions: `nvim-pack-lock.json`, through `:Z update` and `:Z restore` rather than by hand.
