# Asahi Linux Configuration

## How to fix `ip` command not found

You have to install `iproute` package to fix it

```bash
sudo dnf install iproute
```

## How to install C Development tools

You have to install `C Development Tools and Libraries` before restoring `neovim` configuration to `~/.config/nvim`, as it requires the `cc` compiler:

```bash
sudo dnf group install "C Development Tools and Libraries"
```

## How to use `dnf` pacakge manager

### Configuration file: `/etc/dnf/dnf.conf`:

```text
# see `man dnf.conf` for defaults and possible options

[main]
gpgcheck=True
installonly_limit=3
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
allow_vendor_change=False
max_parallel_downloads=10
fastestmirror=True
defaultyes=True
```

### Fish abbreviations

There are a few abbreviations in `~/.config/fish/config.fish`:

```fish
#--------------------------------------------------------
# Package manager
#--------------------------------------------------------
abbr pinstall "sudo dnf install"
abbr pginstall "sudo dnf group install"
abbr psearch "dnf search"
abbr pgsearch "dnf group list | rg"
abbr pinfo "dnf info"
abbr pginfo "dnf group info"
abbr premove "sudo dnf remove"
abbr pgremove "sudo dnf group remove"
abbr pquery "dnf repoquery --installed" # Query only installed packages
# abbr pqueryfile "dnf repoquery --installed --list"
abbr pqueryfile "dnf repoquery --latest 1 --list" # When querying package files, query from repo latest version
```


### Man page and help
For more details, plz read `man dnf`, then you can search keyword like `Install Command, Install Examples, Search Command, Search Examples, Remove Command, Remove Examples` etc, document is quite good actually!!!

Or quick read from here: https://docs.fedoraproject.org/en-US/quick-docs/dnf/


