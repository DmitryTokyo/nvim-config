# nvim-config

Neovim config. Tested on Neovim 0.12.5, macOS arm64.

## Requirements

### brew

```sh
brew install neovim lazygit tree-sitter-cli ripgrep fd
```

| Package | Version |
|---|---|
| neovim | 0.12.5 |
| lazygit | 0.54.2 |
| tree-sitter-cli | 0.27.0 |
| ripgrep | 15.2.0 |
| fd | 10.5.0 |

### npm

```sh
npm i -g basedpyright vscode-langservers-extracted typescript-language-server typescript prettier
```

| Package | Version |
|---|---|
| basedpyright | 1.40.1 |
| vscode-langservers-extracted | 4.10.0 |
| typescript-language-server | 6.0.1 |
| typescript | 7.0.2 |
| prettier | 3.9.9 |

Node: v24.11.1.

### uv

```sh
uv tool install ruff
```

ruff: 0.16.x.

### Font

Nerd Font in the terminal.

## Install

```sh
git clone git@github.com:DmitryTokyo/nvim-config.git ~/.config/nvim
nvim
```

Plugins install on first launch. Check with `:checkhealth`.

## Keymaps

Leader: `<Space>`.

| Keys | Action |
|---|---|
| `<leader>e` | File tree |
| `<leader>ff` / `fg` / `fb` / `fh` | Telescope: files / grep / buffers / help |
| `Ctrl-d` in buffer list | Close buffer |
| `<leader>gg` | LazyGit |
| `s` | Flash jump |
| `Tab` / `Shift-Tab` / `Enter` | Select / confirm completion |
| `Esc` | Clear search highlight |

## Version-sensitive

- native `autocomplete` and `complete`
- `vim.lsp.enable`
- nvim-treesitter `main` branch
