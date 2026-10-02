# nvim-config

Конфиг Neovim (`init.lua`, плагины через lazy.nvim, версии зафиксированы в `lazy-lock.json`).

Написан и проверен на **Neovim 0.12.5** (macOS, arm64). На другой версии могут сломаться
`vim.lsp.enable`, нативный `autocomplete` и ветка `main` у nvim-treesitter.

## Что нужно поставить на новой машине

Версии ниже — те, на которых конфиг работает сейчас.

### Через brew

```sh
brew install neovim lazygit tree-sitter-cli ripgrep fd
```

| Пакет | Версия | Зачем |
|---|---|---|
| neovim | 0.12.5 | сам редактор |
| lazygit | 0.54.2 | `<Space>gg` |
| tree-sitter-cli | 0.27.0 | сборка парсеров nvim-treesitter (ветка `main`) |
| ripgrep | 15.2.0 | `<Space>fg` (live grep в telescope) |
| fd | 10.5.0 | быстрый `<Space>ff` в telescope |

### Через npm (нужен Node, проверено на v24.11.1)

```sh
npm i -g basedpyright vscode-langservers-extracted typescript-language-server typescript prettier
```

| Пакет | Версия | Зачем |
|---|---|---|
| basedpyright | 1.40.1 | LSP для Python |
| vscode-langservers-extracted | 4.10.0 | LSP для HTML, CSS, JSON |
| typescript-language-server | 6.0.1 | LSP для JS/TS |
| typescript | 7.0.2 | нужен typescript-language-server |
| prettier | 3.9.9 | форматирование JS/TS/JSON/HTML/CSS при сохранении |

### Через uv

```sh
uv tool install ruff
```

`ruff format` форматирует Python при сохранении (проверено на 0.16.x).

### Шрифт

Нужен Nerd Font в терминале (проверено в Ghostty), иначе вместо иконок в дереве и статусбаре будут квадраты.

## Установка конфига

```sh
git clone git@github.com:DmitryTokyo/nvim-config.git ~/.config/nvim
nvim
```

lazy.nvim сам поставит плагины при первом запуске. Парсеры treesitter соберутся
автоматически (нужен `tree-sitter-cli`). Проверка: `:checkhealth`.

## Основные хоткеи

Leader — `<Space>`.

| Клавиши | Действие |
|---|---|
| `<leader>e` | дерево файлов |
| `<leader>ff` / `fg` / `fb` / `fh` | telescope: файлы / текст / буферы / справка |
| `Ctrl-d` в списке буферов | закрыть буфер |
| `<leader>gg` | lazygit |
| `s` | flash: прыжок по экрану |
| `Tab` / `Shift-Tab` / `Enter` | выбор и подтверждение подсказки |
| `Esc` | убрать подсветку поиска |

## Если на новой версии Neovim что-то сломалось

Смотри в первую очередь на то, что зависит от версии: нативный `autocomplete` и `complete`,
`vim.lsp.enable`, `vim.lsp.completion`, ветку `main` у nvim-treesitter.
