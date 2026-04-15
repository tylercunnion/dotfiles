# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Personal macOS dotfiles managed via symlinks. Configured tools: Fish shell, Neovim, Tmux, Tig, and dircolors.

## Installation

```sh
make install        # install all configs (creates symlinks)
make install-nvim   # nvim only (also runs install-pynvim.sh)
make install-fish
make install-tmux
make install-tig
make install-dircolors
make clean          # remove all symlinks and pynvim-venv
```

Symlinks are created from the repo directory into `~/.config/` and `$HOME`. For example: `~/.config/nvim → ~/dotfiles/nvim`.

The `install-pynvim.sh` script creates `pynvim-venv/` with the `pynvim` package (used by Neovim's Python host).

## Neovim Architecture

Config lives in `nvim/` and is structured as:

- `init.lua` — sets `python3_host_prog`, then requires `config.options`, `config.keymaps`, `config.theme`
- `lua/config/` — core options, keymaps, and theme modules
- `plugin/` — auto-loaded plugin configurations, one file per concern:
  - `00-packages.lua` — all plugin declarations via `vim.pack.add()` (Neovim's built-in package manager, no lazy.nvim)
  - `completion-lsp.lua` — blink.cmp + mason + nvim-lspconfig + minuet-ai
  - `telescope.lua`, `tree.lua`, `treesitter.lua`, `trouble.lua`
  - `git.lua` — gitsigns, diffview, neogit
  - `testing-debugging.lua` — neotest + neotest-go, nvim-dap + nvim-dap-go
  - `formatting.lua` — conform.nvim
  - `language-specific.lua` — gopher.nvim (Go tools)
  - `editing.lua` — mini.nvim
  - `claude.lua` — claude-preview.nvim
  - `ui.lua` — solarized, lualine, which-key

Plugins are declared in `00-packages.lua` using `vim.pack.add()`. The lock file is `nvim/nvim-pack-lock.json`. After adding or updating plugins, Neovim will run `TSUpdate` or `GoInstallDeps` automatically via the `PackChanged` autocmd.

## Fish Shell

Config in `fish/`:

- `config.fish` — main entry: sets `EDITOR=nvim`, loads Fisher, solarized theme
- `functions/` — Fish function files (autoloaded)
- `conf.d/` — additional config snippets loaded on startup
- `completions/` — custom completions

## Tmux

`tmux.conf` key points:

- Prefix: `Ctrl-E`
- Vi keybindings, mouse support, solarized colors

## Tig

`tigrc` configures the terminal git UI. Includes a binding to open commits via `gh browse`.

## dircolors

`dircolors-solarized/` is a git submodule. The ansi-universal variant is symlinked to `~/.dir_colors`.
