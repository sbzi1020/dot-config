[[ZFS]]
[[bhyve vm]]

## Initial setup
### [[Common operations]]
### doas
```bash
su pkg install doas
which doas

vi /usr/local/etc/doas.conf
# add one rule inside it
# `permit nopass keepenv lab as root`

# change the pevilige of user
pw groupmod wheel -m lab

# set safe permission: make sure only root can access
chown root:wheel /usr/local/etc/doas.conf
chmod 600 /usr/local/etc/doas.conf

# try to use it
doas pkg install XXXXX
```

### Fish
```bash
# check your current shell
echo $SHELL # /bin/sh
doas pkg install fish
which fish # /usr/local/bin/fish
chsh -s /usr/local/bin/fish

# relogin again 
echo $SHELL # /usr/local/bin/fish
```
It should be automatically added to `/etc/shells`, if not, then do:
```bash
echo /usr/local/bin/fish >> /etc/shells
# rerun `chsh` again
chsh -s /usr/local/bin/fish
```
add a `fish` folder and a new file `.config/fish/config.fish`
```
set --export EDITOR "nvim"
#--------------------------------------------------------
# 1. Enable `vi mode` key bindings
# 2. bind `jj` to escape
# 3. bind `ctrl+l` to accept the first suggection
#
# Tips: When u don't know what key (or key combo) to write
#       into the `bind` command, just run `fish_key_reader`
#       binary and press the key (or key combo), it will 
#       print out which `key` you should put into the `bind`
#       command.
#--------------------------------------------------------
set -g fish_key_bindings fish_vi_key_bindings
bind -M insert -m default jj  backward-char force-repaint
bind -M insert \f accept-autosuggestion

#--------------------------------------------------------
# Abbreviation
#--------------------------------------------------------
source $HOME/.config/fish/abbr.fish
# abbr ll "ls -lht"
# abbr vim "nvim"
```

### [[Git Master References]]
```bash
doas pkg install git
git --version
git config --global user.name "Fion Li"
git config --global user.email "li.shangzi3@gmail.com"

# check your settings
git config --list
```
then setup the ssh:
```bash
# generate ssh key
ssh-keygen -t ed25519 -C "li.shangzi3@gmail.com"
# All `Enter` default setting

# start ssh agent and add your key
eval "$(ssh-agent -s)" # bash / Linux
eval (ssh-agent -c) # fish
# Agent pid 2813
ssh-add ~/.ssh/id_ed25519
# Identity added: /home/lab/.ssh/id_ed25519 (li.shangzi3@gmail.com)
cat ~/.ssh/id_ed25519.pub
# copy your publich key and paste to github: settings>ssh keys
```
Other useful git commands
1. working directory (the actual files on your disk)
2. staging area (a binary file`.git/index`): `git add` copies the current content of a file into this staged set
3. local repository(`.git/` directory): `git commit` take everything in the index and writes a permanent snapshot into it.
4. remote(another copy of repo like GitHub): `git push` sends your local commits. `git fetch/pull` get theirs to you.
```bash
# when you create a new project, you must init git
git init

# check all commits
git log -n10 --oneline --decorate --all --graph

# check your files status
git status

# add files into stage area
git add .
git add file_1 file_2

# commit your files to your local repo
git commit -m "your messages"

# push to your remote
git push -u origin
```

|                   |                |                                                                                                                                                                   |                |                               |              |                       |
| ----------------- | -------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------- | ----------------------------- | ------------ | --------------------- |
|                   | git add-->     | generate(.git/objects) hash `e9`/`6504..`<br>- `git hash-object your_file`: get back the hash<br>- `git cat-file [your file's hash number]`: get back the content | git commit --> |                               | git push --> |                       |
| working directory |                | Staging(.git/index)                                                                                                                                               |                | Local repo(.git/objects+refs) |              | Remote(GitHub/server) |
|                   | <--git restore |                                                                                                                                                                   | <--git reset   |                               | <--git fetch |                       |

.git
├── HEAD: ref: refs/heads/master 
├── config
├── description
├── hooks
│   ├── applypatch-msg.sample
│   ├── commit-msg.sample
│   ├── fsmonitor-watchman.sample
│   ├── post-update.sample
│   ├── pre-applypatch.sample
│   ├── pre-commit.sample
│   ├── pre-merge-commit.sample
│   ├── pre-push.sample
│   ├── pre-rebase.sample
│   ├── pre-receive.sample
│   ├── prepare-commit-msg.sample
│   ├── push-to-checkout.sample
│   ├── sendemail-validate.sample
│   └── update.sample
├── info
│   └── exclude
├── objects
│   ├── info
│   └── pack
└── refs
    ├── heads
    └── tags
```bash
# Same content --> Same hash.
# different content --> different hash.
# Because the hash is derived purely from content ("blob 10\0hello git\n" → SHA-1), the same content always yields the same hash
echo "hello git tesing same" | git hash-object --stdin
# e5cd1679ee24b40c25a68f622d504fa5885a5fa4lo

# =============
# working directory
# =============
echo "Hello" > notes.md
mkdir docs && echo "chapter one" > docs/ch1.mc
 # ls -lht
# drwxr-xr-x  2 lab lab  512B Jul 20 21:36 docs/
# -rw-r--r--  1 lab lab    6B Jul 20 21:36 notes.md
 git status
# On branch master
# No commits yet
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#         docs/
#         notes.md

# =============
# staging area
# =============
 git add .
 git status 
# On branch master
# No commits yet
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#         new file:   docs/ch1.mc
#         new file:   notes.md
# ///////////////
.git/objects/
├── 76
│   └── 87376025286a2bd7f080c8426208dabe355e33
├── e9
│   └── 65047ad7c57865823c7d992b1d046ea66edf78
├── info
└── pack
# there are only two hash files created
# you can see the .git/objects/e9/6504..... file created
git hash-object notes.md
# e965047ad7c57865823c7d992b1d046ea66edf78
git cate-file e965
# Hello

# you can see the .git/objects/76/8737..... file created
git hash-object docs/ch1.mc 
# 7687376025286a2bd7f080c8426208dabe355e33
git cat-file -p 7687
# chapter one
 
# =============
# Local repo
# =============
git commit -m "initial commit"
# [master (root-commit) 5d1bb88] initial commit
#  2 files changed, 2 insertions(+)
#  create mode 100644 docs/ch1.mc
#  create mode 100644 notes.md
# //////////
# there are 3 object files have created: 
# 1. one `tree` node(folder) and one `blob` node(file): `docs/ch1.mc`
# 2. one `blob` node(file): `notes.md`
# 3. one `tree` node for: commit message with commiter's info
.git/
├── COMMIT_EDITMSG
.git/objects/
├── .......
├── 36
│   └── 5476b0efe745c1d40483b9f1d032a73f0b02de
├── 5d
│   └── 1bb889ea3184896d089038bd1328fab420abdd
├── 92
│   └── 6d5b414a7fc1715b69344b8694c6e3e8aa8297
├── info
└── pack

 git cat-file -p 3654 # the root tree
# 040000 tree 926d5b414a7fc1715b69344b8694c6e3e8aa8297    docs
# 100644 blob e965047ad7c57865823c7d992b1d046ea66edf78    notes.md
git cat-file -p 926d # the `docs/` subtree
# 100644 blob 7687376025286a2bd7f080c8426208dabe355e33    ch1.mc
 git cat-file -p 5d1b # a leaf 
 # git cat-file -p HEAD(same as .git/refs/heads/master)
# tree 365476b0efe745c1d40483b9f1d032a73f0b02de
# author Fion Li <li.shangzi3@gmail.com> 1784540894 +1200
# committer Fion Li <li.shangzi3@gmail.com> 1784540894 +1200
# initial commit
cat .git/COMMIT_EDITMSG 
# initial commit


git log --oneline
# 5d1bb88 (HEAD -> master) initial commit
cat .git/refs/heads/master # (branch = 1 line = a hash)
5d1bb889ea3184896d089038bd1328fab420abdd

# =============
# remote
# =============
git remote add origin git@github.com:sbzi1020/testing-git-demo.git
git config --list
# remote.origin.url=git@github.com:sbzi1020/testing-git-demo.git
# remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*

git push -u origin master
# Enumerating objects: 5, done.
# Counting objects: 100% (5/5), done.
# Delta compression using up to 8 threads
# Compressing objects: 100% (2/2), done.
# Writing objects: 100% (5/5), 316 bytes | 79.00 KiB/s, done.
# Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
# To github.com:sbzi1020/testing-git-demo.git
#  * [new branch]      master -> master
# branch 'master' set up to track 'origin/master'.

# Files: copies your local objects to the remote; creates refs/remotes/origin/master locally.
├── logs
│   ├── HEAD
│   └── refs
│       ├── heads
│       │   └── master
│       └── remotes  # <-
│           └── origin
│               └── master
└── refs
    ├── heads
    │   └── master
    ├── remotes 
    │   └── origin
    │       └── master # <---
    └── tags
# I cam confirm that the remote GitHub showing this commit.
git log --oneline
# 5d1bb88 (HEAD -> master, origin/master) initial commit

git fetch
# it will generate `.git/FETCH_HEAD` which pointing to current remote  brach
# 5d1bb889ea3184896d089038bd1328fab420abdd                branch 'master' of github.com:sbzi1020/testing-git-demo
└── refs
    ├── heads
    │   └── master
    ├── remotes
    │   └── origin
    │       ├── HEAD # <- ref: refs/remotes/origin/master

    │       └── master # 5d1bb889ea3184896d089038bd1328fab420abdd
git log --oneline
# 5d1bb88 (HEAD -> master, origin/master, origin/HEAD) initial commit

# ======
# Change file again
# ======
 # different content generate different hash value
 echo "Hello world" > notes.md
 git hash-object notes.md
# 802992c4220de19a90767f3000a79a31b98d0df7

# This command will put the new generated Hash value into the objects folder, now there are 6 objects.
git add .

├── objects
│   ├── .....
│   ├── 80  # `notes.md` file with `Hello world`
│   │   └── 2992c4220de19a90767f3000a79a31b98d0df7
│   ├── e9 # `notes.md` file with "Hello"
│   │   └── 65047ad7c57865823c7d992b1d046ea66edf78
git cat-file -p e96504
# Hello
git cat-file -p 8029
# Hello world


git commit -m "second commit"
# [master a67bbd4] second commit
 # 1 file changed, 1 insertion(+), 1 deletion(-)
git cat-file -p fad5
# 040000 tree 926d5b414a7fc1715b69344b8694c6e3e8aa8297    docs
# 100644 blob 802992c4220de19a90767f3000a79a31b98d0df7    notes.md
git cat-file -p a67b
#tree fad58e82f2303ab12573bea8e6563cb2892ede96
#parent 5d1bb889ea3184896d089038bd1328fab420abdd
#author Fion Li <li.shangzi3@gmail.com> 1784619083 +1200
#committer Fion Li <li.shangzi3@gmail.com> 1784619083 +1200
#second commit

├── objects
│   ├── fa
│   │   └── d58e82f2303ab12573bea8e6563cb2892ede96
│   ├── a6
│   │   └── 7bbd481c6911c55f4f4fd8dbf503b5858a6a54

git log --oneline
# a67bbd4 (HEAD -> master) second commit
# 5d1bb88 (origin/master, origin/HEAD) initial commit

# update latest commit(refs/heads/master) sync-> refs/remotes/origin/master
git push -u origin master
# Enumerating objects: 5, done.
# Counting objects: 100% (5/5), done.
# Delta compression using up to 8 threads
# Compressing objects: 100% (2/2), done.
# Writing objects: 100% (3/3), 286 bytes | 286.00 KiB/s, done.
# Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
# To github.com:sbzi1020/testing-git-demo.git
#    5d1bb88..a67bbd4  master -> master
# branch 'master' set up to track 'origin/master'.

# so refs/heads/master and refs/remotes/origin/master are same
# origin/HEAD 
git log --oneline
# a67bbd4 (HEAD -> master, origin/master, origin/HEAD) second commit
# 5d1bb88 initial commit

#=======
# remote updates, local behind,
#=======
git fetch
├── objects
│   ├── 07 # commit msg
│   │   └── 86c42068ea1d112e08d0937f49b29caf6e463a
│   ├── 0c # notes.md changed
│   │   └── 49b1ad7d4a89d8a1ec9790625cc594cfd47a8b
│   ├── 60 # parent node also update
│   │   └── 78f96f6426dcc44e06fa4286f082400a38a9e9
# now remotes/origin/master advance, your local repo still shows the old content
git log -n10 --oneline --decorate --all --graph 
# * 0786c42 (origin/master, origin/HEAD) Update notes.md
# * a67bbd4 (HEAD -> master) second commit
# * 5d1bb88 initial commit

git merge
# Updating a67bbd4..0786c42
# Fast-forward
#  notes.md | 1 +
#  1 file changed, 1 insertion(+)

# now the local HEAD(refs/heads/master) hash value also update to (refs/remotes/origin/master)
git log -n10 --oneline
# 0786c42 (HEAD -> master, origin/master, origin/HEAD) Update notes.md
# a67bbd4 second commit
# 5d1bb88 initial commit


#=======
# remote updates, local updates, conflict
#=======
echo "conflict 1" >> notes.md
git add .
│   ├── 72
│   │   └── 47583f598c4f3fba463193de22d21e1e7f971e
git commit -m "conflict 1"
│   ├── 5b #  treenode
│   │   └── 51c6ae56e88edc3c6eb77493a5c1662b9ea09a
│   ├── a5 #commit msg
│   │   └── 40e99f71f915a220936281d6423c910e684a15

# you can see that local HEAD is advance, remote is behind, you can't do any push before pulling(HEAD and origin/master should be at the same place)
git log --oneline
# a540e99 (HEAD -> master) conflict 1
# 0786c42 (origin/master, origin/HEAD) Update notes.md
# a67bbd4 second commit
# 5d1bb88 initial commit
git push -u origin master
# To github.com:sbzi1020/testing-git-demo.git
#  ! [rejected]        master -> master (fetch first)
# error: failed to push some refs to 'github.com:sbzi1020/testing-git-demo.git'
# hint: Updates were rejected because the remote contains work that you do not
# hint: have locally. This is usually caused by another repository pushing to
# hint: the same ref. If you want to integrate the remote changes, use
# hint: 'git pull' before pushing again.
# hint: See the 'Note about fast-forwards' in 'git push --help' for details.

git pull --no-rebase # git pull with merge
# error: Pulling is not possible because you have unmerged files. hint: Fix them up in the work tree, and then use 'git add/rm <file>' hint: as appropriate to mark resolution and make a commit. fatal: Exiting because of an unresolved conflict.
nvim notes
# Hello world
# from remote
# <<<<<<< HEAD
# conflict 1
# =======
# conflict from remote
# >>>>>>> b347dfb2771a75c9669db733ef8f41196b6767f4

git log -n10 --oneline --decorate --all --graph 
# * b347dfb (origin/master, origin/HEAD) Update notes.md
# | * a540e99 (HEAD -> master) conflict 1
# |/  
# * 0786c42 Update notes.md
# * a67bbd4 second commit
# * 5d1bb88 initial commit

# solve the conflict 
# then add the change to staging
git add .
│   ├── dc
│   │   └── 91e522802750a1373910de15961b0fc6dbaf9b
git commit -m "solve conflict 1"
│   ├── 68 # commit msg
│   │   └── da6275ffb46c72533938a5d5df9fd0ef98d35c
│   ├── f5 # tree node
│   │   └── 010cbc8befcaddc8dbcd9fbcbf92c94c2c8895
 
 git log -n10 --oneline --decorate --all --graph    
# *   68da627 (HEAD -> master) solve conflict 1
# |\  
# | * b347dfb (origin/master, origin/HEAD) Update notes.md
# * | a540e99 conflict 1
# |/  
# * 0786c42 Update notes.md
# * a67bbd4 second commit
# * 5d1bb88 initial commit

# even you amend the original commit msg, its content has changed, so it will generate a new hash object
git commit --amend
│   ├── 07
│   │   ├── 74f768e846e92bf84b40a144fd4f296ca10dae

```
### Neovim
```bash
doas pkg install neovim
which nvim
```
Add a `nvim` folder and a new file `.config/nvim/init.lua`
	If you have already installed Git, then `nvim` , it will automatically installed all packages in your `init.lua`
### Kitty (terminal)
```bash
doas pkg install kitty
kitty --version
```
Add a `kitty` and a new file `.config/kitty/kitty.conf`
```
confirm_os_window_close 0
# Fonts
font_family         JetBrainsMonoNerdFont
bold_font           auto
italic_font         auto
bold_italic_font    auto
font_size           16

# Misc
scrollback_lines    5000
scrollbar           never

# UI
background_opacity  0.9

# Layouts
enabled_layouts     Tall,stack

window_padding_width    10
window_border_width     1

# Tab
tab_bar_edge            bottom
tab_bar_align           center
tab_bar_min_tabs        1
tab_title_max_length    40
tab_bar_margin_height   40
tab_bar_style           slant

# Keybinding
kitty_mode              ctrl+shift

# change font size
map ctrl+minus change_font_size all -2.0
map ctrl+equal change_font_size all +2.0

# Scrolling way
map alt+n scroll_line_up
map alt+m scroll_line_down

# split windows
map alt+t new_window
map alt+w close_window
map alt+i set_window_title
map alt+h neighboring_window left
map alt+l neighboring_window right
map alt+j neighboring_window bottom
map alt+k neighboring_window top

# toggle the stack layout
map alt+z toggle_layout stack

# resize window
map alt+r start_resizing_window

map ctrl+shift+space launch --stdin-source=@screen_scrollback --type=overlay nvim +"set nospell" -
```
Add font:
```bash
pkg search nerd-fonts
pkg install nerd-fonts
```