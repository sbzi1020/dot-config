## PDF

| Key                | Action                       |
| ------------------ | ---------------------------- |
| ==`j` / `Down`==   | ==Scroll down==              |
| ==`k` / `Up`==     | ==Scroll up==                |
| `h` / `Left`       | Scroll left                  |
| `l` / `Right`      | Scroll right                 |
| `Ctrl+d`           | Scroll half page down        |
| `Ctrl+u`           | Scroll half page up          |
| `Ctrl+f` / `Space` | Scroll full page down        |
| `Ctrl+b`           | Scroll full page up          |
| ==`H`==                | ==Go to top of current page==    |
| ==`L`==                | ==Go to bottom of current page== |
| `0`                | Scroll to far left           |
| `$`                | Scroll to far right          |
## Navigation — Pages

| Key                  | Action                     |
| -------------------- | -------------------------- |
| ==`J` / `PageDown`== | ==Next page==              |
| ==`K` / `PageUp`==   | ==Previous page==          |
| ==`gg`==             | ==First page==             |
| ==`G`==              | ==Last page==              |
| `<n>G`               | Go to page number _n_      |
| `<n>%`               | Go to _n_% of the document |
| `o`                  | Open "go to page" prompt   |
## Zoom & Fit

| Key                 | Action                 |
| ------------------- | ---------------------- |
| `+` / `zi`          | Zoom in                |
| `-` / `zo`          | Zoom out               |
| `=` / `z=`          | Zoom to original size  |
| `<n>Z`              | Zoom to _n_%           |
| ==`a`==             | ==Fit to page height== |
| `s`                 | Fit to page width      |
| Mouse `Ctrl+Scroll` | Zoom in/out            |
|                     |                        |

## View Modes

|Key|Action|
|---|---|
|`d`|Toggle dual-page (two-column) view|
|`r`|Rotate 90° clockwise|
|`i`|Invert / recolor (night mode)|
|`Ctrl+m`|Toggle input bar visibility|
|`F5`|Presentation mode|
|`F11`|Fullscreen|
|`Esc`|Abort / return to normal mode|

## Search

| Key   | Action                 |
| ----- | ---------------------- |
| ==`/`==   | ==Search forward==         |
| ==`?`==   | ==Search backward==        |
| `n`   | Next match             |
| `N`   | Previous match         |
| `Esc` | Clear search highlight |

## Table of Contents (Index)

|Key|Action|
|---|---|
|`Tab`|Toggle table of contents / index|
|`j` / `k`|Move down / up through entries|
|`l` / `Space`|Expand collapsed section|
|`h`|Collapse section|
|`Enter`|Jump to selected entry|
|`Tab` / `Esc`|Close index|

## Links & Hints

|Key|Action|
|---|---|
|`f`|Follow link (shows hint numbers)|
|`F`|Show link target / copy link|

## Marks (bookmarks within a session)

| Key         | Action                         |
| ----------- | ------------------------------ |
| ==`m<letter>`== | ==Set a mark at current position== |
| ==`'<letter>`== | ==Jump to a saved mark==           |

## File / Misc

|Key|Action|
|---|---|
|`R`|Reload the document|
|`p`|Print|
|`q`|Quit|
|`Ctrl+c`|Abort current action|

## Command Mode (type `:` first)

| Command                 | Action                      |
| ----------------------- | --------------------------- |
| `:open <file>` or `:o`  | Open a document             |
| `:quit` or `:q`         | Quit                        |
| `:print`                | Print document              |
| `:write <file>`         | Save a copy                 |
| `:bmark <name>`         | Add a bookmark              |
| `:blist`                | List bookmarks              |
| `:bdelete <name>`       | Delete a bookmark           |
| `:set <option> <value>` | Change a setting at runtime |
| `:nohlsearch`           | Clear search highlights     |
| `:exec <cmd>`           | Run an external command     |
| `:info`                 | Show document information   |
| jkkk`:help`             | Show help                   |