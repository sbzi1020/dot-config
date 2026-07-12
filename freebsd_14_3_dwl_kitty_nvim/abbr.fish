# Clear console
abbr c "clear"

abbr ll "ls -lht"

# Abbreviation for `dust` and map it to `du`
# Make sure you already install it by running: cargo install du-dust
abbr du "dust -d1"
abbr ps "procs"


#--------------------------------------------------------
# Docker
#--------------------------------------------------------
abbr d "docker"
abbr dr "docker run --rm --tty=true --interactive=true"
abbr drv "docker run --rm --tty=true --interactive=true --volume=HOST_DIR:VM_DIR"
abbr drn "docker run --rm --tty=true --interactive=true --volume=HOST_DIR:/usr/share/nginx/html:ro --publish=8080:80 --name nginx-web-server nginx:stable-alpine-slim"
abbr di "docker images"
abbr dii "docker image inspect --format '{{.Os}}/{{.Architecture}}' "
abbr dps "docker ps -a"
abbr dns "docker network ls"
#abbr d-rm-all "docker rm $(docker container ls -a -q)"
#abbr d-stop-a l "docker stop $(docker container ls -a -q)"
#abbr d-rmi-all "docker rmi $(docker image ls -a -q)"
abbr dc "docker-compose"
abbr dm "docker-machine"
abbr startdocker "doas sv up /var/service/docker"
abbr stopdocker "doas sv down /var/service/docker"


#--------------------------------------------------------
# Open configuration
#--------------------------------------------------------
abbr vim "nvim"
abbr ac "emacs --no-window-system ~/.alacritty.toml"
abbr fc "emacs --no-window-system ~/.config/fish/config.fish"
abbr rc "emacs --no-window-system ~/.config/river/init"
abbr kc "emacs --no-window-system ~/.config/kitty/kitty.conf"
abbr vc "cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"


#--------------------------------------------------------
# Git related
#--------------------------------------------------------
abbr gs "git status"
abbr gb "git branch"
abbr gl "git log -n10 --oneline --decorate --all --graph"
abbr ga "git add"
abbr gf "git diff HEAD"
abbr gc "git commit -nm"
abbr gck "git checkout"
abbr gcl "git clone --depth=1"
abbr gp "git push -u origin"
abbr grs "git remote -v show"
abbr grc "gh repo create REPO_NAME_HERE --private --source . --push"
abbr grd "gh repo delete --yes OWNER_NAME/REPO_NAME"
abbr grl "gh repo list --language all"
abbr giv "gh issue view ISSUE_NUMBER_HERE | nvim -c \"set filetype=markdown\""
abbr givc "gh issue view ISSUE_NUMBER_HERE --comments | nvim -c \"set filetype=markdown\""


#--------------------------------------------------------
# Sourcehut (CLI) related
#--------------------------------------------------------
abbr "shrc" "hut git create REPO_NAME_HERE --visibility private" # source hut repo create
abbr "shrd" "hut git delete REPO_NAME_HERE"                      # source hut repo delete
abbr "shrl" "hut git list"                                       # source hut repo list
abbr "shrs" "hut git show"                                       # source hut repo show (ULR, info)


#--------------------------------------------------------
# Rust related
#--------------------------------------------------------
abbr cn "cargo new"
abbr cc "cargo check"
abbr cr "cargo run"
abbr ct "cargo test"
abbr cw "cargo watch"
abbr cwr "cargo watch -c --exec run"
abbr cwt "cargo watch -c --exec 'test -- --nocapture'"


#--------------------------------------------------------
# Tmux related
#--------------------------------------------------------
# abbr tn "tmux new -s dev"
# abbr tc "nvim ~/.tmux.conf"
# abbr tl "tmux ls"
# abbr ta "tmux attach-session -t dev"
# abbr tk "tmux kill-server"


#--------------------------------------------------------
# Iproute2 related
#--------------------------------------------------------
abbr ip "ip"
abbr ipj "ip --json"

# iproute2 related: Net status
# nst - net status tcp all
# nsu - net status udp all
# nstl - net status tcp listening
# abbr ns "ss"
abbr nst "ss --tcp --numeric --processes"
abbr nstl "ss --tcp --numeric --processes --listening"
abbr nsu "ss --udp --all --numeric --processes"
abbr nsx "ss --unix --all --numeric --processes"

#--------------------------------------------------------
# Show system information
#--------------------------------------------------------
abbr nf "neofetch"
abbr ff "fastfetch"


#--------------------------------------------------------
# Package manager
#--------------------------------------------------------
abbr pinstall "doas pkg install"
abbr psearch "pkg search --origins"
abbr pinfo "pkg info"
abbr pinfo2 "pkg search --origins --full -e"
# Query all installed
abbr pqueryall "pkg info --all | rg"
# Query installed package file list
abbr pqueryfile "pkg info --list-files"
# Remove a software and the unneeded dependencies
abbr premove "doas pkg delete"


#--------------------------------------------------------
# shutdown
# abbr exitx "killall xinit"
abbr shutdown "doas poweroff"


#--------------------------------------------------------
# Python
#--------------------------------------------------------
abbr python "python3"


#--------------------------------------------------------
# Google Cloud SDK
#--------------------------------------------------------
abbr g "gcloud"
abbr gi "gcloud info"
abbr gal "gcloud auth list"
abbr gpl "gcloud projects list"
abbr gsl "gcloud run services list"
abbr gsd "gcloud run services describe NAME --region=australia-southeast1"
# abbr gcl "gcloud config list"


#--------------------------------------------------------
# Iptables
#--------------------------------------------------------
abbr iptreload "doas ~/.config/iptables/basic.fish"
abbr iptrestore "doas ~/.config/iptables/temp-restore-iptables.fish"
abbr iptl "doas iptables -t filter --list -v"
abbr iptlr "doas iptables -t filter --list-rules"
abbr iptlog "journalctl -k --grep=\"IN=.*OUT=.*\""


#--------------------------------------------------------
# History
#--------------------------------------------------------
# History with datetime
abbr h "history --show-time=\"%Y-%m-%d %H:%M:%S \""


#--------------------------------------------------------
# emacs
#--------------------------------------------------------
abbr e "emacs"
abbr es "emacs --daemon --debug-init"
abbr kes "emacsclient -e \(\"kill-emacs\"\)"
abbr et "emacs --no-window-system"
abbr eg "emacs &"

abbr emacs-backup "cp -rvf ~/.config/emacs/{init.el, configuration.org, lib, snippets, bookmarks, todo.org, themes, temp.el, my-abbrevs.el, lisp-quick-tutorial.org, GEMINI.md, early-init.el, captures} ./emacs"

abbr emacs-restore "cp -rvf ./emacs/{init.el, configuration.org, lib, snippets, bookmarks, todo.org, themes, temp.el, my-abbrevs.el, lisp-quick-tutorial.org, GEMINI.md, early-init.el, captures} ~/.config/emacs"


#--------------------------------------------------------
# Hyprland
#--------------------------------------------------------
# abbr hpc "nvim ~/.config/hypr/hyprland.conf"
# abbr hpm "hyprctl monitors all"
# abbr exith "hyprctl dispatch exit"
# abbr cwp "swww img --transition-type wipe --transition-angle 45 ~/Photos/wallpaper/"


#--------------------------------------------------------
# River
#--------------------------------------------------------
abbr exitr "riverctl exit"


#--------------------------------------------------------
# MPV realted
#--------------------------------------------------------

# Best video and audio quality
abbr mpvh "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=ytdl"

# Middle video and audio quality
abbr mpv  "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=best"

# Low video and audio quality
abbr mpvl "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=worst"

# Play a paylist file
abbr mpvpl "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=worst --playlist="


#--------------------------------------------------------
# Youtube download related
#--------------------------------------------------------
abbr yda "yt-dlp -f ba "


#--------------------------------------------------------
# Zig
#--------------------------------------------------------
#
# Zig build: enable watch mode and increamental compilation and show errors
#
abbr zbw "zig build --watch -fincremental --prominent-compile-errors"

#
# Build statically-linked binrary from a zig source file
#
# zig build-obj -O ReleaseFast src/main.zig && clang -o my-main -O3 -static main.o && strip my-main && rm -rf main.o
abbr zbs "zig build-obj -OReleaseSmall src/main.zig && clang -o my-main -O3 -static main.o && strip my-main && rm -rf main.o"


#----------------------------------------------------------
# Claude code relatede
#----------------------------------------------------------
abbr cl "$HOME/.claude/local/claude"


#----------------------------------------------------------
# SQLite
#----------------------------------------------------------
abbr sql "sqlite3"


#--------------------------------------------------------
# fzf
#--------------------------------------------------------
abbr fzf "fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})'"
abbr fzfp "fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,10% --padding=2,5 --info=right --no-separator --highlight-line --preview='bat {}' --preview-window=right,60%,nowrap --multi --bind 'ctrl-a:toggle-all,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,ctrl-e:execute(nvim {})'"
abbr fzft "fzf --exact --ignore-case --border=rounded --layout=reverse --tmux --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})'"
abbr fzftp "fzf --exact --ignore-case --border=rounded --layout=reverse --tmux=80%,70% --padding=2,5 --info=right --no-separator --highlight-line --preview='bat {}' --preview-window=right,60%,nowrap --multi --bind 'ctrl-a:toggle-all,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up,ctrl-e:execute(nvim {})'"

#
# History with datetime and use fzf to search then copy to clipboard
#
abbr hc "history --show-time=\"%Y-%m-%d %H:%M:%S \" | fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line | cut -d ' ' -f 3- | wl-copy"

#
# Run `ps` and pass the selected process id to `kill -9`
#
abbr psk "procs | fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --ansi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})' | awk '{print \$1}' | xargs kill -9"

#
# Enable `fzf` default keybinding commands:
#
# `Ctrl-t`: select files
# `Ctrl-r`: select history
# `alt/super-c`: select and cd into directories
#
#set --export FZF_TMUX_HEIGHT 60%
#set --export FZF_CTRL_T_OPTS "--exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})'"
#fzf --fish | source


#----------------------------------------------------------
# fzf, one key to lanuch `fzf_cd` (select folder to change)
#----------------------------------------------------------

#
# Cd into the folder that you pick from `fzf` and bind to `Alt-c`
#
function fzf_cd
    set --local folder (fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})' --walker=dir --walker-root=$HOME)
    # echo "folder: $folder"

    if test -n "$folder"
        # echo ">>> cd into: $folder"
        builtin cd $folder
    end
end

# #
# # It only works for version >= 4.0.1, but currently FreeBSD 14.3
# # only has `3.7.1`, that's why bind to `Alt/Super` key doesn't
# # work!!!!
# #
# function fzf_setup_keybindings
#     #
#     # `ç` is the keycode shows from `fish_key_reader -V` when pressing `Alt+c`
#     #
#     bind \cP fzf_cd force-repaint
#     bind -M insert \cP fzf_cd force-repaint
#
#     echo ">>>> Bind key to 'fzf_cd' [ done ]"
# end
# fzf_setup_keybindings

abbr dir "fzf_cd"


#----------------------------------------------------------
# `cd` related
#----------------------------------------------------------
abbr cdb "cd ~/my-shell/backup"
abbr cde "cd ~/.config/emacs"
abbr cdn "cd ~/.config/nvim"
abbr cdw "cd ~/.config/wezterm"
abbr cdg "cd ~/.config/ghostty"
abbr cdk "cd ~/.config/kitty"


#----------------------------------------------------------
# zfs
#----------------------------------------------------------
abbr zsl "zfs list -t snapshot"
abbr zsr "zfs rollback -r zroot@"
# abbr zsc "doas zfs diff zroot/ROOT/void@my-base zroot/ROOT/void@new"
abbr zsc "echo 'doas zfs snapshot -r zroot@SNAPSHOT_NAME_HERE'"


#----------------------------------------------------------
# Useful CLI pipe examples
#----------------------------------------------------------
abbr users "curl \"https://jsonplaceholder.typicode.com/users?_limit=5\" | rg \"username\" | awk '{print \$2}' | sed s/\\\"//g  | sed s/,//g | fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})' | xargs -I @ echo \n\n\nHey, the user name is: '@'\n"

abbr photos "curl \"https://jsonplaceholder.typicode.com/photos?_limit=10\" | rg url | awk '{print \$2}' | sed -e s/\\\"//g -e s/,//g | fzf --exact --ignore-case --border=rounded --layout=reverse  --margin=10%,20% --padding=2,5 --info=right --no-separator --highlight-line --multi --bind 'ctrl-a:toggle-all,ctrl-e:execute(nvim {})' | xargs -I @ curl \"@\" -O"


# #--------------------------------------------------------
# # Wezterm related
# #--------------------------------------------------------
# abbr w "wezterm"

# # Kill the wezterm multiplexing (domain) server
# abbr wk "kill -9 (cat $XDG_RUNTIME_DIR/wezterm/pid)"

# # List all workspaces
# abbr wl "wezterm cli list --format json | jq -r '.[] | .workspace' | sort -u"


# #--------------------------------------------------------
# # Ghostty related
# #--------------------------------------------------------
# abbr g "ghostty"
# abbr glf "ghostty +list-fonts | bat"
# abbr gla "ghostty +list-actions | bat"
# abbr glk "ghostty +list-keybinds | bat"
# abbr gsc "ghostty +show-config | bat"


#--------------------------------------------------------
# Image related
#--------------------------------------------------------
abbr image "nsxiv"


#--------------------------------------------------------
# `zmx` related
#--------------------------------------------------------
abbr z "zmx"

function zmx-session-picker
    set --local output (zmx list 2>/dev/null | while read -l -d \t name pid clients dir
        set name (string replace 'session_name=' '' $name)
        set pid (string replace 'pid=' '' $pid)
        set dir (string replace 'started_in=' '' $dir)
        printf "%-20s  pid:%-8s  clients:%-2s  %s\n" $name $pid $clients $dir
    end | \
    sed -e 's/name=//g' -e 's/→//g' -e 's/^[[:space:]]*//' | \
    awk -v OFS='\t' '{print $1, $5}'  | \
    fzf \
        --print-query \
        --expect=ctrl-n \
        --height=80% \
        --reverse \
        --prompt="zmx> " \
        --header="Enter: select | Ctrl-N: create new" \
        --preview='zmx history {1} | tail -50' \
        --preview-window=right,60%,nowrap \
    )
    set --local rc $status
    # echo ">>> rc: $rc"

    # User input (e.g. filter keyword or new session name)
    set --local query $output[1]
    # User pressed key (e.g. `ctrl-n`
    set --local key $output[2]
    # The selected item by pressing enter or default after filtering
    set --local selected $output[3]
    # echo ">>> query: $query"
    # echo ">>> key: $key"
    # echo ">>> selected: $selected"


    set --local session_name ""

    if test "$key" = ctrl-n && test -n "$query"
        set session_name $query
    else if test $rc -eq 0 && test -n "$selected"
        set session_name (echo $selected | awk '{print $1}')
    else
        return 130
    end

    # ">>> session_name: $session_name"

    zmx attach $session_name
end

function kill-zmx-sessions -d "Kill all exsting 'zmx' sessions"
    printf ">>> [ kill-zmx-sessions ]\n\n"

    set --local killed_session_amount 0
    for session_name in (zmx list --short)
	zmx kill $session_name
	# printf "\n>>> killed session: %s" $session_name
	set killed_session_amount (math $killed_session_amount + 1)
    end

    printf "\n>>> Total killed session amount: %s\n" $killed_session_amount
end

# TMUX style abbr with zmx implementation
abbr tl "zmx-session-picker"
abbr tk "kill-zmx-sessions"
abbr ta "zmx attach default.1"


#--------------------------------------------------------
# Jai
#--------------------------------------------------------
abbr jai "jai-linux"

