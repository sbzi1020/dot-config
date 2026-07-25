# Git Master Reference

A condensed, diagram-first reference. Everything is either **an object**, **a pointer**, or **a command that moves content/pointers between areas**.

---

## 1. The core mental model

Git is a **content-addressed snapshot store** + **movable labels**.

```
   HEAD  ───▶  branch  ───▶  commit  ───▶  tree  ───▶  blobs
 "where am I" "a label"  "a snapshot"  "dir listing" "file bytes"
```

- **Only two things ever MOVE:** the **branch label** and **HEAD**.
- **Commits / trees / blobs are immutable** — named by the hash of their content, never change.

### The four object types

| Object | Holds | Named by |
|--------|-------|----------|
| **blob** | one file's raw contents (no name/path) | hash of its bytes |
| **tree** | a directory listing: names → blob/tree hashes + modes | hash of its content |
| **commit** | one root tree + parent(s) + author + message | hash of its content |
| **tag** | annotated pointer to a commit | hash of its content |

**Hash rule:** same content → same hash, always, everywhere. Different content → different hash. This is why identical files are stored **once** (dedup) and why a "modified" file is detected (its bytes now hash differently).

---

## 2. The three areas + remote

```
 WORKING DIR ──git add──▶ STAGING (index) ──git commit──▶ LOCAL .git ──git push──▶ REMOTE
   edit files              .git/index                    objects/+refs           GitHub
      ▲                                                       │                     │
      └──── restore / reset / checkout ◀──────────────────────┴── fetch / pull ◀────┘
```

| Area | Lives in | Moved by |
|------|----------|----------|
| Working directory | real files on disk | your editor |
| Staging area (index) | `.git/index` | `git add`, `git restore --staged` |
| Local repository | `.git/objects`, `.git/refs` | `git commit`, `git reset` |
| Remote | another repo copy | `git push`, `git fetch`, `git pull` |

---

## 3. `.git/` layout

```
.git/
├── HEAD              # "ref: refs/heads/main"  (which branch you're on)
├── index             # staging area (binary)
├── config            # repo config + remotes
├── objects/          # ALL blobs, trees, commits
│   ├── ab/cdef...    # object "abcdef..." (first 2 chars = subdir), zlib-compressed
│   └── pack/         # delta-compressed bundles
├── refs/
│   ├── heads/main    # a branch = 1 file containing 1 commit hash
│   ├── remotes/origin/main
│   └── tags/
└── logs/             # reflog: history of ref movements
```

---

## 4. Porcelain → Plumbing mapping

Every friendly command is a wrapper over low-level plumbing.

| You type (porcelain) | Runs underneath (plumbing) | What it writes |
|---|---|---|
| `git init` | writes `HEAD`,`config`,`objects/`,`refs/` | creates `.git/` |
| `git add f` | `hash-object -w f` → `update-index --add f` | blob → objects; entry → index |
| `git commit -m` | `write-tree` → `commit-tree` → `update-ref` | tree+commit → objects; ref moves |
| `git branch b` | `update-ref refs/heads/b <hash>` | one ref file |
| `git switch b` | `symbolic-ref HEAD refs/heads/b` + `read-tree` | moves HEAD; updates index+workdir |
| `git reset` | `update-ref` (+ optional `read-tree`/checkout) | ref (+ index + workdir) |
| `git restore f` | `checkout-index` / `read-tree` | index→workdir, or commit→index |
| `git revert c` | inverse `commit-tree` + `update-ref` | new commit ahead |
| `git push` | `pack-objects` + `send-pack` | uploads objects; moves remote ref |
| `git fetch` | `fetch-pack` + `update-ref refs/remotes/...` | downloads objects; moves remote-tracking ref |

### The three plumbing verbs that do everything

```
hash-object -w  →  bytes  become a blob      (content → objects/)
write-tree      →  index  becomes a tree     (staging → snapshot dir)
commit-tree     →  tree   becomes a commit   (snapshot → history node; -p = parent)
update-ref      →  branch pointer moves to a hash
```

---

## 5. Lifecycle with real plumbing + verification

```
 git init ─────────────────────────────▶ empty .git/

 echo "hello" > a.txt                     WORKING DIR

 git add a.txt
   = hash-object -w a.txt   ─▶ blob b6fc4c6 in objects
     update-index --add     ─▶ index: a.txt→b6fc4c6

 git commit -m "first"
   = write-tree             ─▶ tree 9daeafb
     commit-tree 9daeafb    ─▶ commit fcfecf2 (tree+parent+msg)
     update-ref refs/heads/main fcfecf2
```

**Verify each layer:**
```sh
git cat-file -p HEAD           # commit: "tree 9daeafb", author, msg
git cat-file -p HEAD^{tree}    # tree:   "100644 blob b6fc4c6  a.txt"
git cat-file -p b6fc4c6        # blob:   "hello"
git ls-tree HEAD               # mode type hash name
cat .git/refs/heads/main       # fcfecf2...
```

**Key gotcha:** `git hash-object f` only *computes* the hash — writes nothing. Use `-w` (or `git add`) to actually store the object, otherwise `git cat-file` on that hash fails.

| Command | Computes hash | Writes object |
|---------|:---:|:---:|
| `git hash-object f` | ✅ | ❌ |
| `git hash-object -w f` | ✅ | ✅ |
| `git add f` | ✅ | ✅ |
| `git cat-file -p <hash>` | — | reads only (fails if not written) |

---

## 6. Pointer operations — the heart of Git

```
 git commit  : BRANCH label moves forward   (HEAD rides along)
 git reset   : BRANCH label moves to any commit (usually back) — rewrites history
 git switch  : HEAD moves to a different branch (your view changes)
 git branch  : ADD a new label at current commit (nothing moves)
 git tag     : ADD a PINNED label (never follows new commits)
```

| Command | Moves what | Touches files | "Goes to" commit |
|---------|-----------|:---:|:---:|
| `commit` | branch label → forward | — | — |
| `reset` | branch label → any commit | optional | ✅ branch becomes it |
| `switch`/`checkout <branch>` | HEAD → branch | ✅ | ✅ (view) |
| `branch b` | adds label (nothing moves) | ❌ | ❌ |
| `tag t` | adds pinned label | ❌ | ❌ |

**Branch vs tag:** commit new work →
- branch label **moves** to the new commit,
- tag **stays** on the old commit (marks a fixed release).

---

## 7. reset vs restore (the big confusion)

|  | `git reset` | `git restore` |
|---|---|---|
| Operates on | whole **commits** (a pointer) | **file contents** (paths) |
| Moves branch/HEAD? | **YES** | **NEVER** |
| Think of it as | "move where the branch points" | "copy a saved file version into an area" |
| Danger | can rewrite history | safe, local, file-only |

> `git reset` has TWO modes:
> - `git reset [--soft/--mixed/--hard] <commit>` → **moves the branch pointer**
> - `git reset <commit> <file>` → **path mode, does NOT move pointer** (just unstages)
>
> `git restore --staged f` was created (Git 2.23) to do that unstage job with a command that **cannot** touch history. `git reset HEAD f` and `git restore --staged f` are identical in effect.

---

## 8. reset — the three flags

**Rule:** reset moves the branch pointer; the flag decides how many areas follow.

```
                branch label │  INDEX  │ WORKING DIR
 reset --soft      moved      │  kept   │   kept        un-commit, work stays STAGED
 reset --mixed     moved      │  reset  │   kept        un-commit, work UNSTAGED (default)
 reset --hard      moved      │  reset  │  reset ⚠      un-commit AND delete work
```

The commit isn't deleted — it becomes unreferenced and is recoverable via reflog until `git gc`.

---

## 9. restore — copy a blob between areas (never moves pointers)

```
   COMMIT ──restore --staged f──▶ INDEX ──restore f──▶ WORKING DIR
```

| Goal | Command | Direction |
|------|---------|-----------|
| Discard working-dir edits | `git restore f` | index → working |
| Unstage, keep edits | `git restore --staged f` | commit → index |
| Both (unstage + discard) | `git restore --staged --worktree f` | commit → index+working |
| Pull an old version of a file | `git restore --source=HEAD~3 f` | old commit → working |

### `--source` can be ANY commit-ish

```sh
git restore --source=HEAD f          # current commit
git restore --source=HEAD~3 f        # older commit
git restore --source=main f          # tip of a branch
git restore --source=feature f       # ANOTHER branch's version
git restore --source=v1.0 f          # a tag
git restore --source=origin/main f   # a remote-tracking branch
git restore --source=5d1bb88 f       # any raw commit hash
git restore .                        # ALL tracked files (bulk content copy)
git restore --source=HEAD~3 .        # every file back to that snapshot (still uncommitted)
```

**Scope:** restore works on **paths** — one file, many files, a directory, or `.` (everything). Even `git restore --source=X .` only changes **file contents**; it never moves the branch or HEAD, so you stay where you are and the files show as *modified*.

**Boundary:** the source must already exist in your object DB. Untracked files (never added) have no blob → use `git clean`, not restore. Commits on an un-fetched remote → `git fetch` first.

---

## 10. cherry-pick vs restore — "pull from anywhere onto here"

Both reach across the whole repo, but touch different things:

```
cherry-pick Fx (on main):  C1 ─ C2 ─ C3 ─ Fx'   ← NEW COMMIT added, branch moves forward
restore --source=feature f: C1 ─ C2 ─ C3         ← branch UNCHANGED; file just modified in workdir
                                       ↑ main (did not move)
```

| | `git cherry-pick` | `git restore --source=` |
|---|---|---|
| Grabs from | any commit (branch/tag/hash) | any commit (branch/tag/hash) |
| Unit | a whole **commit's change (diff)** | a **file's content (snapshot blob)** |
| Applies as | **new commit** → branch advances | **uncommitted** change in working dir |
| Moves pointer / history? | ✅ yes | ❌ never |
| Can conflict? | ✅ (applies a diff) | ❌ (overwrites file wholesale) |

```
cherry-pick : apply a COMMIT's CHANGE from anywhere → as a NEW COMMIT on current branch
restore     : copy a FILE's CONTENT   from anywhere → into WORKING DIR (uncommitted)
```

---

## 11. Undo decision table + reset vs revert + reflog

| I want to… | Command | Danger |
|---|---|---|
| Discard edits to a file (uncommitted) | `git restore <file>` | loses that file's edits |
| Unstage a file (keep edits) | `git restore --staged <file>` | safe |
| Undo last commit, keep work **staged** | `git reset --soft HEAD~1` | safe |
| Undo last commit, keep work **unstaged** | `git reset --mixed HEAD~1` | safe |
| Undo last commit **and delete work** | `git reset --hard HEAD~1` | ⚠ destructive |
| Undo a commit **already pushed** | `git revert <commit>` | safe (adds a commit) |
| Delete untracked files/dirs | `git clean -fd` (preview `-n`) | ⚠ destructive |

### reset vs revert

```
reset  : 5d1bb88 ── 9f9f9f9 (HEAD)   →   5d1bb88 (HEAD)   [pointer moved BACK, rewrites history]
revert : 5d1bb88 ── 9f9f9f9 (HEAD)   →   5d1bb88 ── 9f9f9f9 ── e7e7e7 (HEAD)  [NEW inverse commit]
```
- Not pushed yet → `reset` is fine.
- Already pushed / shared → use `revert` (never rewrites shared history).

### Reflog — the safety net

```sh
git reflog                  # every position HEAD has held
#   fcfecf2 HEAD@{1}: commit: second
git reset --hard fcfecf2    # jump back to it
```
`--soft`/`--mixed` always recoverable. `--hard`/`clean` lose only *uncommitted* work; committed work is recoverable via reflog until `git gc`.

---

## 12. Branch & switch

A branch is a **one-line file** (`.git/refs/heads/<name>`) holding one commit hash.

```sh
git branch                       # list (* = current)
git branch -a                    # include remote-tracking
git branch <name>                # CREATE label at HEAD (does NOT switch)
git branch -d <name>  | -D       # delete (safe) | force
git branch -m <old> <new>        # rename
git switch <name>                # move HEAD to branch (updates workdir)
git switch -c <name>             # create + switch
git switch -c <name> <start>     # branch from a specific commit/branch/tag
git switch -                     # switch to previous branch
git checkout <commit> -- <file>  # restore ONE file (old style; prefer restore)
```

```
 git branch b   :  ADD label at current commit      HEAD unchanged  ── you stay put
 git switch b   :  MOVE HEAD to branch b             workdir updates ── you "go" there
 git switch -c b:  ADD label + MOVE HEAD onto it     workdir unchanged (same commit)
```

| Command | Creates label | Moves HEAD | Updates workdir |
|---------|:---:|:---:|:---:|
| `git branch b` | ✅ | ❌ | ❌ |
| `git switch b` | ❌ | ✅ | ✅ |
| `git switch -c b` | ✅ | ✅ | ❌ (same commit) |

### Why `switch` over `checkout`

`checkout` was overloaded (switch branch / restore file / detach HEAD). Git 2.23 split it by intent:

| Intent | Modern | Old overloaded form |
|--------|--------|---------------------|
| Change branch (move HEAD) | `git switch` | `git checkout <branch>` |
| Restore file contents | `git restore` | `git checkout <c> -- <file>` |

`switch` can't clobber a file and won't detach HEAD unless you pass `--detach`. `checkout` still works — just less safe.

---

## 13. Merge

```sh
git merge <branch>        # merge <branch> INTO current
git merge --no-ff <b>     # force a merge commit even if fast-forward possible
git merge --squash <b>    # combine b's changes into ONE staged change (no merge commit)
git merge --abort         # bail out of an in-progress conflicted merge
```

```
FAST-FORWARD (current branch has no commits of its own):
   C1 ── C2 ── C3 ── C4          main just SLIDES forward to C4, no new commit
                     ↑ main

3-WAY MERGE (both branches advanced → histories diverged):
        C3 (main)
       /          \
 C1 ─ C2           M  ← NEW merge commit (2 parents)
       \          /
        C4 (feature)
```

| Situation | Result |
|-----------|--------|
| Current branch has no new commits | fast-forward: pointer slides, no merge commit |
| Both branches diverged | merge commit `M` with two parents |
| `--no-ff` | always makes a merge commit (preserves branch shape) |
| `--squash` | flattens b's work into one staged diff; you commit manually |

---

## 14. Rebase

Replays your commits **on top of** another branch → linear history. Rewrites commits (new hashes). **Never rebase commits already pushed/shared.**

```sh
git rebase <branch>       # replay current branch's commits onto <branch>
git rebase -i HEAD~3      # interactive: squash/reword/reorder/drop last 3
git rebase --continue     # after resolving a conflict
git rebase --skip         # skip the current conflicting commit
git rebase --abort        # bail out, restore original state
```

```
START:          C1 ─ C2 ─ X ─ Y   (your branch)
                     \
                      A ─ B         (other branch)

MERGE  git merge other:
   C1 ─ C2 ─ X ─ Y ─── M            keeps fork, adds merge commit M
        \             /
         A ─────── B

REBASE git rebase other:
   C1 ─ C2 ─ A ─ B ─ X' ─ Y'        linear; X,Y REWRITTEN as X',Y' (new hashes)
```

| | Merge | Rebase |
|---|---|---|
| History shape | preserves fork (braided) | linear |
| New hashes | no (adds merge commit) | yes (rewrites your commits) |
| Safe on shared branch | ✅ | ❌ |
| Use when | integrating shared work | tidying local commits before push |

### Interactive rebase verbs

| Verb | Action |
|------|--------|
| `pick` | keep commit as-is |
| `reword` | keep, edit its message |
| `edit` | pause to amend the commit |
| `squash` | merge into previous commit, combine messages |
| `fixup` | merge into previous commit, discard this message |
| `drop` | delete the commit |
| (reorder lines) | reorders commits |

---

## 15. Cherry-pick

Apply a single commit from anywhere onto your current branch (new hash).

```sh
git cherry-pick <commit>       # apply that commit's change here
git cherry-pick <c1> <c2>      # multiple
git cherry-pick -n <commit>    # apply but don't commit (stage only)
git cherry-pick --continue     # after resolving conflict
git cherry-pick --abort
```

```
 main:    C1 ─ C2 ─ C3            feature:  ... ─ Fx
 git cherry-pick Fx  (on main)
 main:    C1 ─ C2 ─ C3 ─ Fx'      ← Fx replayed onto main as a NEW commit Fx'
```

---

## 16. Conflict workflow (merge / rebase / cherry-pick) — detailed

A conflict happens when two sides changed the **same lines** (or one edited a file the other deleted) and Git can't decide which wins. The operation **pauses** and hands you the file to resolve. This applies identically to `merge`, `rebase`, and `cherry-pick`.

### 16.1 Detect

```sh
# operation stops with: "CONFLICT (content): Merge conflict in <file>"
git status                    # "Unmerged paths" lists conflicted files
git diff                      # shows the conflicting hunks
git diff --name-only --diff-filter=U   # just the conflicted filenames
git ls-files -u               # low-level: the 3 staged versions (see below)
```

### 16.2 Anatomy of the markers

Git writes **both versions** into the file, wrapped in markers:

```
<<<<<<< HEAD                (also labeled "ours")
your version (current branch)
||||||| merged common ancestor    ← only with merge.conflictStyle=diff3/zdiff3
the ORIGINAL shared version
=======
their version (incoming branch/commit)
>>>>>>> feature             (also labeled "theirs")
```

- **HEAD / ours** = what your current branch has.
- **theirs** = what you're merging/rebasing/picking in.
- Enable the ancestor view (very helpful) once:
  ```sh
  git config --global merge.conflictStyle zdiff3
  ```

> ⚠ **Rebase flips "ours" and "theirs".** During a rebase you're replaying *your* commits onto the other branch, so **ours = the branch you're rebasing ONTO**, **theirs = your commit being replayed**. Feels backwards vs merge — check with `git status`.

### 16.3 Resolve

Pick one side, combine both, or write something new — then **delete all `<<<<`, `====`, `||||`, `>>>>` markers**.

```sh
# resolve by hand: edit the file, remove markers, keep the correct content
#   OR take one whole side wholesale:
git checkout --ours   <file>     # keep HEAD's version entirely
git checkout --theirs <file>     # keep incoming version entirely
git restore --source=MERGE_HEAD <file>   # pull the incoming version via restore
```

### 16.4 Mark resolved + continue

```sh
git add <file>                # staging a conflicted file = "this one is resolved"
git status                    # confirm no more "Unmerged paths"

git merge --continue          # finish the merge (opens commit msg)
git rebase --continue         # finish/advance the rebase
git cherry-pick --continue    # finish the cherry-pick
```

For a **file deleted on one side**: decide keep or delete —
```sh
git add <file>    # keep it   |   git rm <file>   # accept the deletion
```

### 16.5 Bail out

```sh
git merge --abort         # restore pre-merge state exactly
git rebase --abort        # restore pre-rebase state exactly
git cherry-pick --abort
git rebase --skip         # drop just the current conflicting commit, continue
```

### 16.6 Tools & shortcuts

```sh
git mergetool                 # launch a configured 3-way merge GUI
git diff                      # review your resolution before adding
git checkout --conflict=diff3 <file>   # re-expand markers WITH the ancestor
```

### 16.7 rerere — auto-reuse past resolutions

If you hit the *same* conflict repeatedly (common with long rebases):
```sh
git config --global rerere.enabled true   # "reuse recorded resolution"
```
Git remembers how you resolved a given conflict and re-applies it automatically next time.

### 16.8 The universal loop

```
 1. command stops → "CONFLICT ..."
 2. git status                      # which files
 3. edit files → remove <<<< ==== >>>> markers   (or --ours/--theirs)
 4. git add <file>                  # mark each resolved
 5. git <op> --continue             # merge / rebase / cherry-pick
    ── OR ──
    git <op> --abort                # give up, restore original state
```

---

## 17. Stash — shelve work-in-progress

```sh
git stash                   # shelve tracked changes, clean working dir
git stash -u                # ALSO include untracked files
git stash -a                # include ignored files too
git stash push -m "msg" <f> # stash specific files, with a label
git stash list              # stash@{0}, stash@{1}, ...
git stash show -p stash@{0} # view a stash's diff
git stash pop               # reapply newest + REMOVE from stack
git stash apply             # reapply but KEEP in stack
git stash apply stash@{2}   # reapply a specific stash
git stash drop stash@{0}    # delete one entry
git stash clear             # delete ALL
git stash branch <name>     # create a branch from a stash + pop it there
```

```
 WORKING DIR (dirty) ──git stash──▶ stash@{0}   +   WORKING DIR (clean)
                     ◀──git stash pop── (reapply, then drop)
                     ◀──git stash apply─ (reapply, keep)
```

| Command | Reapplies | Removes from stack |
|---------|:---:|:---:|
| `git stash pop` | ✅ | ✅ |
| `git stash apply` | ✅ | ❌ |
| `git stash drop` | ❌ | ✅ |

| Situation | Command |
|-----------|---------|
| Switch branch but tree is dirty | `git stash` → switch → `git stash pop` |
| Pull onto a dirty tree | `git stash` → `git pull` → `git stash pop` |
| Stashed work belongs on its own branch | `git stash branch feature-x` |
| Shelve incl. untracked files | `git stash -u` |

---

## 18. fetch vs pull

```
git fetch  : updates refs/remotes/origin/*  +  FETCH_HEAD    (local branch + files UNTOUCHED)
git pull   = git fetch  +  git merge origin/<branch>          (branch + working dir updated)
git pull --rebase = git fetch  +  git rebase origin/<branch>  (linear)
```

| Step | `origin/main` ref | local `main` ref | working dir |
|------|:---:|:---:|:---:|
| `git fetch` | ✅ | ❌ | ❌ |
| `git merge origin/main` | ❌ | ✅ | ✅ |
| `git pull` | ✅ | ✅ | ✅ |

### Divergent branches (the "need to specify how to reconcile" error)

Both sides have unique commits. Choose:

| Option | Command | Result |
|--------|---------|--------|
| merge | `git pull --no-rebase` (`pull.rebase false`) | adds a merge commit `M`, keeps fork |
| rebase | `git pull --rebase` (`pull.rebase true`) | replays your commits on top → linear, new hashes |
| ff-only | `git config pull.ff only` | refuses unless a pure fast-forward is possible |

**Fast-forward** = your branch is purely *behind*; Git just slides the pointer forward, no new commit. Only possible when you have no unique local commits.

---

## 19. Command reference by task

```
SETUP    config --global user.name/email · init.defaultBranch · alias.lg
CREATE   init · clone <url> [dir] · clone --depth 1
CYCLE    status · add [-A|-p] · restore [--staged] · commit [-m|-am|--amend]
INSPECT  log [--oneline --graph --all] · show <c> · diff [--staged] · blame f
OBJECTS  hash-object [-w] · cat-file -t/-p · ls-tree [-r] HEAD · rev-parse HEAD[^{tree}]
BRANCH   branch [-a|-d|-D|-m] · switch [-c] · checkout <c> -- <file>
MERGE    merge [--no-ff|--squash|--abort]
REBASE   rebase <b> · rebase -i HEAD~n · --continue/--skip/--abort
PICK     cherry-pick <c> [-n] · --continue/--abort
UNDO     restore [--staged] · reset --soft/--mixed/--hard · revert · clean -fd (-n)
STASH    stash [-u] · list · show -p · pop/apply/drop/clear · branch <name>
TAG      tag [-a -m] · show · push origin <tag> · push --tags
REMOTE   remote -v/add/set-url · fetch · pull [--rebase] · push [-u] · push --force-with-lease
SAFETY   reflog · reset --hard HEAD@{n}
MAINT    gc · prune · fsck --full · count-objects -vH
```

---

## 20. Golden rules

1. **Only labels (branches/tags) and HEAD move.** Commits/trees/blobs are immutable.
2. **Same content → same hash.** Change one byte → new hash. That's how Git detects changes and dedups.
3. **`hash-object` without `-w` writes nothing** — `cat-file` will fail on that hash.
4. **`reset` = pointer/history. `restore` = file content.** Different jobs, not two versions of one tool.
5. **`--hard` and `clean` lose only *uncommitted* work.** Committed work is recoverable via reflog until `gc`.
6. **Not pushed → `reset`. Already pushed → `revert`.** Never rewrite shared history.
7. **cherry-pick commits; restore doesn't.** Both pull from anywhere, but only cherry-pick moves your branch.
