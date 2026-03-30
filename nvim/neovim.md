# Neovim Configuration

A Go-focused development environment built on modern, lua-native plugins. Primary languages: Go, Python, JavaScript/TypeScript, Lua.

---

## Architecture

```
nvim/
├── init.lua                  # Entry point
├── lua/
│   ├── config/
│   │   ├── options.lua       # Editor settings
│   │   ├── keymaps.lua       # Global keymaps (leader key)
│   │   ├── lazy.lua          # Lazy.nvim bootstrap
│   │   └── theme.lua         # Colorscheme + macOS sync
│   └── plugins/              # One file per plugin
└── lazy-lock.json            # Pinned plugin versions
```

Plugin management is handled by **Lazy.nvim**, bootstrapped automatically on first launch. Each plugin lives in its own file under `lua/plugins/` and is auto-discovered.

Load order in `init.lua`: options → keymaps → lazy bootstrap → plugin loading → theme.

---

## Theme

**Colorscheme:** `solarized.nvim` (maxmx03) using the `selenized` palette with italic comments.

**macOS sync:** On startup and every time Neovim regains focus, `theme.lua` queries the system appearance via `defaults read -g AppleInterfaceStyle`. If the system is in Dark Mode, `vim.o.background` is set to `dark`; otherwise `light`. This means the colorscheme tracks your macOS appearance automatically with no manual intervention.

---

## Editor Options

| Setting | Value | Notes |
|---------|-------|-------|
| Leader key | `,` | |
| Indentation | 4 spaces | expandtab, tabstop/softtabstop/shiftwidth all 4 |
| Scroll offset | 8 lines | Keeps cursor away from edges |
| Line numbers | on | |
| Cursor line | highlighted | |
| Undo persistence | on | Undo history survives restarts (`undofile`) |
| True color | on | `termguicolors` |
| Sign column | always visible | Prevents layout shift when signs appear |

**Diagnostics** display as virtual text (● prefix) in normal mode only (`update_in_insert = false`), with source shown when multiple diagnostics exist. Float windows use rounded borders.

---

## AI Completions

Two AI sources feed into the completion engine simultaneously.

### GitHub Copilot (`copilot.lua`)
Cloud-based completions via `zbirenbaum/copilot.lua`. Suggestions and the panel UI are disabled — Copilot runs as a pure data source feeding into blink.cmp rather than managing its own UI.

### Minuet AI (`minuet-ai.nvim`)
Local model completions via LMStudio running at `http://localhost:1234`. Currently configured for `mistralai/devstral-small-2-2512` with a 16k context window, 256 max tokens, and 0.15 temperature. Minuet completions appear in the same blink menu as LSP suggestions, distinguished by a `󰚩` icon and given a score boost (`score_offset = 50`) to surface them higher.

### blink.cmp
The completion engine that unifies all sources. Sources in priority order: LSP, path, snippets, buffer, minuet. Key bindings:

| Key | Action |
|-----|--------|
| `<C-space>` | Open/toggle completion menu |
| `<C-y>` / `<CR>` | Accept selection |
| `<C-e>` | Dismiss menu |
| `<C-p>` / `<C-n>` | Navigate items |
| `<C-u>` / `<C-d>` | Scroll documentation |

---

## LSP

Configured via `nvim-lspconfig` with capabilities fed from blink.cmp so the completion engine and language servers stay in sync.

### Active Language Servers

**gopls** (Go) — the primary Go language server. Key settings:
- `gofumpt = true` — stricter gofmt formatting enforced by the LSP
- `staticcheck = true` — additional static analysis beyond the default analyzers
- `unusedparams` and `shadow` analyses enabled
- `completeUnimported = true` — auto-imports packages on completion
- `usePlaceholders = true` — function completions include parameter placeholders
- Inlay hints enabled for variable types and composite literal fields

**golangci-lint-langserver** — surfaces golangci-lint results as LSP diagnostics in real time. Activates when `.golangci.yml`, `.golangci.yaml`, or `go.mod` is found at the project root.

### LSP Keybindings

These are set on every buffer when an LSP attaches:

| Key | Action |
|-----|--------|
| `gd` | Go to definition (Telescope) |
| `gD` | Go to type definition (Telescope) |
| `gi` | Go to implementation (Telescope) |
| `gr` | Find references (Telescope) |
| `K` | Hover documentation |
| `gh` | Signature help |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>lR` | Rename symbol |
| `<leader>ll` | Run code lens |

### Tool Installation

**Mason** manages installation of external tools (language servers, formatters, linters). Run `:Mason` to open the UI. **mason-lspconfig** bridges Mason with nvim-lspconfig so installed servers are automatically configured.

---

## Go Development

### gopls
See the LSP section above. gopls is the core of the Go workflow — hover docs, go-to-definition, auto-imports, and inlay hints all come from it.

### gopher.nvim
Provides Go-specific code actions that sit above what gopls offers: generating interface implementations, adding struct tags, running `go mod tidy`, and similar operations. Lazy-loads on `.go` files only. Access via `:Gopher` commands or the `:GoInstallDeps` build step installs its required binaries automatically.

### lazydev.nvim
Improves the Lua development experience when editing Neovim config itself — provides LuaLS completions for the Neovim API and `vim.uv` (libuv bindings). Loads only for `.lua` files.

### Formatting on Save

`conform.nvim` runs formatters automatically on save (1 second timeout, falls back to LSP formatting if a formatter isn't available).

**Go formatter chain** (run in sequence):
1. **gci** — organizes and groups imports. Configured with three sections: standard library, third-party, and `github.com/temporalio` (internal) imports separated.
2. **gofumpt** — stricter `gofmt`. Enforces additional style rules beyond the standard formatter.
3. **golines** — wraps long lines at 80 characters, using gofumpt as its base formatter so the two don't conflict.

**Other languages:**
- Python → `black`
- JavaScript / TypeScript → `prettier`
- Lua → `stylua`
- HTML, CSS, SCSS, JSON, YAML, Markdown → `prettier`

---

## Testing

**neotest** + **neotest-go** provide a test runner UI integrated directly into the editor. Tests load lazily on Go files.

neotest-go is configured with:
- `-count=1` — disables Go's test result cache so every run is fresh
- `-timeout=60s` — per-test timeout
- `test_table = true` — experimental support for table-driven test display

### Key Workflows

**Run the test under your cursor:** `<leader>tt` — neotest detects the nearest test function and runs it.

**Run all tests in the file:** `<leader>tf`

**Debug a test:** `<leader>td` — runs the nearest test via the DAP strategy, handing off to nvim-dap-go and opening the debug UI automatically.

**Summary panel:** `<leader>ts` — opens a tree view of all tests in the project showing pass/fail status. Navigate and re-run from here.

**Output:** `<leader>to` opens the output for the nearest test. `<leader>tO` toggles a persistent output panel at the bottom.

See `which-key` (`,` then wait) for the full `<leader>t` map.

---

## Debugging

**nvim-dap** with **nvim-dap-go** and **nvim-dap-ui**. The UI opens and closes automatically when a debug session starts and ends.

### Control Flow

| Key | Action |
|-----|--------|
| `<F6>` | Continue |
| `<F9>` | Terminate |
| `<F10>` | Step over |
| `<F11>` | Step into |
| `<F12>` | Step out |

### Breakpoints & UI

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint (prompts for expression) |
| `<leader>du` | Toggle DAP UI manually |

### Go-Specific

| Key | Action |
|-----|--------|
| `<leader>dt` | Debug test under cursor (via dap-go) |
| `<leader>dT` | Re-debug last test |

The difference between `<leader>dt` (dap-go direct) and `<leader>td` (neotest→dap) is subtle: dap-go's version is slightly lower-level and useful when neotest isn't loaded or for non-table tests. In normal use, prefer `<leader>td` from neotest.

---

## Git

Three complementary plugins cover the full git workflow.

### gitsigns.nvim
Loads on every buffer in a git repo. Shows add/change/delete signs in the gutter using `▎` / `` characters.

**Hunk navigation:** `]h` / `[h` — jump between changed hunks. Works correctly in diff mode.

**Staging workflow:** Select lines in visual mode then `<leader>gs` to stage just that selection. Or `<leader>gS` to stage the whole buffer. `<leader>gu` undoes the last stage operation without touching the working tree.

**Blame:** `<leader>gb` shows full commit info for the current line in a float. `<leader>gB` toggles inline blame on every line.

**Text object:** `ih` in operator/visual mode selects the current hunk — e.g. `dih` deletes a hunk, `yih` yanks it.

### Neogit
A Magit-inspired git client. Open with `<leader>gg`. From the status buffer you can stage/unstage files and hunks, write commit messages, pull, push, rebase, and manage branches. Neogit uses diffview for its diff windows.

### diffview.nvim
Rich diff and history viewer.

| Key | Action |
|-----|--------|
| `<leader>gD` | Full working tree diff (all changed files) |
| `<leader>gh` | Commit history for the current file |
| `<leader>gH` | Full repo commit history |

In the file history view you can navigate commits and see the exact diff for each. Merge conflicts are shown in a 3-way split layout.

---

## Navigation

### Telescope
Fuzzy finder used by LSP keybindings for definitions, implementations, and references. Also available directly for file finding and grep. Pinned to branch `0.1.x`.

### nvim-tree
File explorer. Toggle with `<F5>`. Replaces netrw. Shows file icons via nvim-web-devicons (requires a Nerd Font in your terminal).

### Treesitter Context
Shows the enclosing scope (function, struct, if block, etc.) as a sticky header at the top of the window. Displays up to 3 lines of context. Useful when reading long functions where the signature has scrolled off screen.

---

## Diagnostics

**Trouble.nvim** provides a structured panel for navigating diagnostics, LSP symbols, and quickfix/location lists.

| Key | Action |
|-----|--------|
| `<leader>xx` | All workspace diagnostics |
| `<leader>xX` | Current buffer diagnostics only |
| `<leader>cs` | Symbol tree (functions, types, variables) |
| `<leader>cl` | LSP definitions/references panel (right side) |

---

## UI

### lualine
Status line showing: mode, git branch, diff stats, diagnostics, filename, encoding, filetype, progress, and cursor position. Theme follows the colorscheme automatically.

### which-key
Press `,` (leader) and pause — a popup appears showing all available keybindings under that prefix. Registered groups:

| Prefix | Group |
|--------|-------|
| `,g` | git |
| `,d` | debug |
| `,t` | test |
| `,x` | diagnostics |
| `,c` | code |
| `,l` | lsp |
| `[` | prev (hunks, diagnostics, etc.) |
| `]` | next |

### mini.pairs
Auto-closes `()`, `[]`, `{}`, `""`, `''`, and ` `` `. The `'` pair uses a word-boundary neighbor pattern so it doesn't close inside contractions (e.g. `don't`).

---

## Python Environment

Neovim's Python provider points to a dedicated venv at `~/dotfiles/pynvim-venv/`. This keeps the `pynvim` package isolated from the system Python. If Python plugins misbehave, check that this venv exists and has `pynvim` installed:

```sh
~/dotfiles/pynvim-venv/bin/pip install pynvim
```

---

## Adding / Updating Plugins

Create a new file in `lua/plugins/` — Lazy auto-discovers it. To pin or update versions, run `:Lazy update` or edit `lazy-lock.json` directly. Run `:Lazy sync` after manual lock file edits.

New language servers and formatters should be installed through Mason (`:Mason`) and then wired into `nvim-lspconfig` or `conform.nvim` as appropriate.
