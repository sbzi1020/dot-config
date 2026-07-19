[[river-keybindings]]
[[Zathura PDF Viewer]]


## Kitty

| key                  | action                         |
| -------------------- | ------------------------------ |
| ==shift+ctrl+space== | ==copy terminal output texts== |
| Alt + n/m            | `n` mode: scroll up/down       |
| Alt + t              | create a new terminal          |
| Alt + h/l/j/k        | jump left/right/bottom/top     |
| Alt + z              | toggle stack: full screen      |
| Alt + f              | full screen                    |
| Alt + w              | kill current window            |
| Alt + i              | set window title               |
| Alt + r              | resizing window                |
## dwl

| key               | action             |
| ----------------- | ------------------ |
| shift + alt + h/l | move around window |

### Nvim
#### General
| Keybinding | Mode   | Action                         |
| ---------- | ------ | ------------------------------ |
| `W`        | Normal | Save file (`:w`)               |
| `Q`        | Normal | Quit (`:q`)                    |
| `jj`       | Insert | Escape to normal mode          |
| `Ctrl + s` | Normal | Replace all words under cursor |
| `Space`    | —      | Leader key                     |
#### Oil (file manager)
| Keybinding    | Mode   | Action                      |
| ------------- | ------ | --------------------------- |
| `Leader + p`  | Normal | Open parent directory       |
| `Leader + sb` | Normal | Open ~/sbzi directory       |
| `Leader + r`  | Normal | Open root directory         |
| `l`           | Oil    | Select entry                |
| `h`           | Oil    | Go to parent                |
| `q`           | Oil    | Close Oil                   |
| `a`           | Oil    | Toggle hidden files         |
| `s`           | Oil    | Change sort                 |
| `y`           | Oil    | Yank entry                  |
| `n`           | Oil    | Copy entry filename         |
| `C`           | Oil    | Copy to system clipboard    |
| `V`           | Oil    | Paste from system clipboard |

#### Buffer Navigation
| Keybinding        | Mode   | Action                        |
| ----------------- | ------ | ----------------------------- |
| `Tab`             | Normal | Next buffer                   |
| `Shift + Tab`     | Normal | Previous buffer               |
| `Leader + Leader` | Normal | Switch to other (last) buffer |
|                   |        |                               |

#### Window Management
| Keybinding | Mode | Action |
|------------|------|--------|
| `Leader + vs` | Normal | Vertical split |
| `Ctrl + h` | Normal | Go to left window |
| `Ctrl + l` | Normal | Go to right window |
| `-` | Normal | Shrink window vertically (−5) |
| `=` | Normal | Grow window vertically (+5) |
| `\|` | Normal | Equalize window sizes |

#### Line Movement
| Keybinding | Mode | Action |
|------------|------|--------|
| `J` | Visual | Move selection down |
| `K` | Visual | Move selection up |

#### Search & Navigation
| Keybinding | Mode | Action |
|------------|------|--------|
| `L` | Normal | Go to end of line |
| `H` | Normal | Go to start of line |
| `AL` | Normal | Select all |
| `Esc` | Insert/Normal | Clear search highlight + escape |
| `n` | Normal/Visual | Next search result (always forward) |
| `N` | Normal/Visual | Previous search result (always backward) |

#### Text Editing
| Keybinding | Mode | Action |
|------------|------|--------|
| `<` | Visual | Indent left, stay in visual mode |
| `>` | Visual | Indent right, stay in visual mode |
| `p` | Visual | Paste without overwriting clipboard |
| `Ctrl + c` | Normal | Copy whole file to clipboard |
| `` ` `` | Insert | Auto-close backticks |
| `"` | Insert | Auto-close double quotes |
| `(` | Insert | Auto-close parentheses |
| `[` | Insert | Auto-close square brackets |
| `{` | Insert | Auto-close curly braces |
| `<` | Insert | Auto-close angle brackets |

#### File Operations
| Keybinding | Mode | Action |
|------------|------|--------|
| `Ctrl + s` | Insert/Visual/Normal/Select | Save file |
| `Leader + nf` | Normal | New file |
| `Leader + qq` | Normal | Quit all |
| `mm` | Normal | Bookmark current position |
| `gb` | Normal | Go back to last bookmark |

#### Development Tools
| Keybinding | Mode | Action |
|------------|------|--------|
| `gco` | Normal | Add comment below |
| `gcO` | Normal | Add comment above |
| `Leader + xl` | Normal | Toggle location list |
| `Leader + xq` | Normal | Toggle quickfix list |
| `[q` | Normal | Previous quickfix item |
| `]q` | Normal | Next quickfix item |
| `Leader + ui` | Normal | Inspect position (highlights) |
| `Leader + uI` | Normal | Inspect treesitter tree |
| `Leader + K` | Normal | Keyword help for word under cursor |

#### Terminal
| Keybinding | Mode     | Action             |
| ---------- | -------- | ------------------ |
| `Esc Esc`  | Terminal | Enter normal mode  |
| `Ctrl + h` | Terminal | Go to left window  |
| `Ctrl + j` | Terminal | Go to lower window |
| `Ctrl + k` | Terminal | Go to upper window |
| `Ctrl + l` | Terminal | Go to right window |
| `Ctrl + /` | Terminal | Hide terminal      |

#### Folding
| Keybinding | Mode | Action |
|------------|------|--------|
| `zv` | Normal | Close all folds except current |
| `zj` | Normal | Close current fold, open next |
| `zk` | Normal | Close current fold, open previous |

#### Utility
| Keybinding | Mode | Action |
|------------|------|--------|
| `Leader + tw` | Normal | Toggle line wrapping |
| `z0` | Normal | Fix spelling (first suggestion) |
| `Ctrl + j` | Command-line | Move down in command history |
| `Ctrl + k` | Command-line | Move up in command history |