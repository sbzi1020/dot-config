# vim: ft=fish
set --export CLICOLOR "xterm-color"
set --export LSCOLORS "gxfxcxdxbxegedabagacad"
set --export EDITOR nvim
set --export QT_QPA_PLATFORMTHEME "qt5ct"

source ~/.cache/wal/colors-fish.fish

#--------------------------------------------------------
# Set `man pager`
#--------------------------------------------------------

# Use `bat` as man pager
# set --export MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Use `nvim` as man pager
# set --export MANPAGER "nvim -c 'set ft=man' -"

#--------------------------------------------------------
# Fish  greeting
#--------------------------------------------------------
function fish_greeting
    echo -en ""(show_os_info)"\n"
    echo -en ""(show_cpu_info)"\n"
    echo -en ""(show_network_info)"\n"
    echo ""
end

function show_os_info -d "Prints operating system info"
    set_color $color1
    echo -en " >  "
    echo -en (uname -m)
    set_color normal
end

function show_cpu_info -d "Prints information about cpu"
    set --local os_type (uname -s)

    if [ $os_type = "Linux" ]
        set --local basic_cpu_info (lscpu | grep "Model name" | tr -s " " | cut -d : -f2)
        set --local cores_n (lscpu | grep "CPU(s)" | head -n 1 | tr -s " " |  cut -d : -f2)
        set cpu_info "$basic_cpu_info [ $cores_n cores ]"
    else if [ $os_type = "Darwin" ]
        set --local basic_cpu_info (sysctl -n machdep.cpu.brand_string)
        set --local cores_n (sysctl -n machdep.cpu.core_count)
        set cpu_info "$basic_cpu_info [ $cores_n cores ]"
    else if [ $os_type = "FreeBSD" ]
        set --local basic_cpu_info (sysctl hw.model | cut -d: -f2)
        set --local cores_n (sysctl hw.ncpu | cut -d: -f2)
        set cpu_info "$basic_cpu_info [ $cores_n cores ]"
    end

    set_color $color1
    echo -en " >"
    echo -en $cpu_info
    set_color normal
end

function show_network_info -d "Prints information about network"
    set --local os_type (uname -s)

    if [ $os_type = "Linux" ]
        set --local ip (ip address show | grep -E "inet .* global" | cut -d " " -f6)
        set --local gw (ip route | grep default | cut -d " " -f3)
        set network_info "IP: $ip, Default gateway: $gw"
    else if [ $os_type = "Darwin" ]
        set --local ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set --local gw (netstat -nr | grep -E "default.*UGSc" | cut -d " " -f13)
        set network_info "IP: $ip, Default gateway: $gw"
    else if [ $os_type = "FreeBSD" ]
        set --local ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set --local gw (netstat -nr | grep -E "default" | cut -d " " -f13)
        set network_info "IP: $ip, Default gateway: $gw"
    end

    set_color $color1
    echo -en " > "
    echo -en $network_info
    set_color normal
end

#--------------------------------------------------------
# Fish VI mode prompt
#--------------------------------------------------------
function fish_default_mode_prompt --description 'Display the default mode for the prompt'
    # Do nothing if not in vi mode
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
        switch $fish_bind_mode
            case default
                set_color A4CA9E
                echo ' N '
            case insert
                set_color F7CE76
                echo ' I '
            case replace_one
                set_color green
                echo ' R '
            case replace
                set_color cyan
                echo ' R '
            case visual
                set_color C49BC9
                echo ' V '
        end
        set_color normal
    end
end

#--------------------------------------------------------
# Fish prompt
#--------------------------------------------------------
function fish_prompt
    set_color $color2 --bold
    printf " %s | " "$USER"

    # set_color E66B17 --bold
    # set_color bf4300 --bold
    set_color $color1 --bold

    printf "%s %s " "$PWD" ""
    # printf "%s%s " "$PWD" ""

    set_color normal
    printf " "
end

set -U fish_color_user ff5f5f

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
# ~/my-shell
#--------------------------------------------------------
set PATH ~/my-shell ~/my-shell/zig-nightly $PATH


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
abbr di "docker images"
abbr dii "docker image inspect --format '{{.Os}}/{{.Architecture}}' "
abbr dps "docker ps -a"
abbr dns "docker network ls"
#abbr d-rm-all "docker rm $(docker container ls -a -q)"
#abbr d-stop-a l "docker stop $(docker container ls -a -q)"
#abbr d-rmi-all "docker rmi $(docker image ls -a -q)"
abbr dc "docker-compose"
abbr dm "docker-machine"
abbr startdocker "doas systemctl start docker"
abbr stopdocker "doas systemctl stop docker"


#--------------------------------------------------------
# Open configuration in vim
#--------------------------------------------------------
abbr vim "nvim"
abbr fc "nvim ~/.config/fish/config.fish"
abbr vc "cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
abbr ac "nvim ~/.alacritty.toml"


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
abbr grc "gh repo create REPO_NAME_HERE --private --source . --push"
abbr grd "gh repo delete --yes OWNER_NAME/REPO_NAME"
abbr grl "gh repo list --language all"


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
abbr tr "tmux source-file ~/.tmux.conf"
abbr tn "tmux new -s dev"
abbr tc "nvim ~/.tmux.conf"
abbr tl "tmux ls"
abbr ta "tmux attach-session -t dev"
abbr tk "tmux kill-server"


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
abbr nst "ss --numeric --processes --all --tcp"
abbr nstl "ss --numeric --processes --listening --tcp"
abbr nsu "ss --numeric --processes --all --udp"
abbr ns "ip route show"


#--------------------------------------------------------
# Show system information
#--------------------------------------------------------
abbr fb "firebase"
abbr fbe "firebase emulators:start"


#--------------------------------------------------------
# Show system information
#--------------------------------------------------------
abbr nf "neofetch"
abbr ff "fastfetch"

# Screen lock
abbr sl "xlock -mode matrix"

#--------------------------------------------------------
# Package manager
#--------------------------------------------------------
# Packge install
abbr pinstall "doas pacman --sync --refresh"
# Packge search
abbr psearch "pacman --sync --search"
# Packge info
abbr pinfo "pacman --sync --info"
# pacman query all installed
abbr pqueryall "pacman --query | sort | bat"
# pacman query installed
abbr pqueryinfo "pacman --query --info"
# pacman query installed package file list
abbr pqueryfile "pacman --query --list"
# pacman remove a software and the unneeded dependencies
abbr premove "doas pacman -Rsun"
# pacman clean cache
abbr pcleancache "doas pacman -Scc"
# pacman upgrade all installed packages
abbr pupgrade "doas pacman --sync --refresh --sysupgrade"


#--------------------------------------------------------
# BSP and hotkey
#--------------------------------------------------------
abbr bc "nvim ~/.config/bspwm/bspwmrc"
abbr pc "nvim ~/.config/polybar/config"
abbr sc "nvim ~/.config/sxhkd/sxhkdrc"


#--------------------------------------------------------
# exit X and shutdown
#--------------------------------------------------------
abbr exitx "killall xinit"
abbr shutdown "doas shutdown --poweroff now"


#--------------------------------------------------------
# Python
#--------------------------------------------------------
abbr python "python3"
set PATH $HOME/.local/bin $PATH


#--------------------------------------------------------
# Google Cloud SDK
#--------------------------------------------------------
abbr g "gcloud"
abbr gi "gcloud info"
abbr gal "gcloud auth list"
# abbr gcl "gcloud config list"


#--------------------------------------------------------
# Zig tmux sessions
#--------------------------------------------------------
abbr taz "tmux attach-session -t \"z-utils\""
abbr tab "tmux attach-session -t \"Zig book tutorial\""
abbr tae "tmux attach-session -t \"Emacs configuration\""
abbr tae "tmux attach-session -t \"Emacs configuration\""

#--------------------------------------------------------
# Tutorial
#--------------------------------------------------------
abbr tat "tmux attach-session -t \"RP2040 Embedded Tutorial\""

#--------------------------------------------------------
# Hare
#--------------------------------------------------------
abbr tah "tmux attach-session -t 'Hare Development'"
abbr tam "tmux attach-session -t 'ME (My Editor)'"


#--------------------------------------------------------
# Rust - Cargo
#--------------------------------------------------------
set PATH $HOME/.cargo/bin $PATH
set LD_LIBRARY_PATH (rustc --print sysroot)"/lib"
set RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/library"


#--------------------------------------------------------
# `lf` file manager wrapper script and icons settings
#--------------------------------------------------------
abbr lc "nvim ~/.config/lf/lfrc"

export LF_ICONS="\
tw=:\
st=:\
ow=:\
dt=:\
di=:\
fi=:\
ln=:\
or=:\
ex=:\
*.c=:\
*.cc=:\
*.clj=:\
*.coffee=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.erl=:\
*.exs=:\
*.fs=:\
*.go=:\
*.h=:\
*.hh=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.java=:\
*.jl=:\
*.js=:\
*.json=:\
*.lua=:\
*.md=:\
*.php=:\
*.pl=:\
*.pro=:\
*.py=:\
*.rb=:\
*.rs=:\
*.scala=:\
*.ts=:\
*.vim=:\
*.cmd=:\
*.ps1=:\
*.sh=:\
*.bash=:\
*.zsh=:\
*.fish=:\
*.tar=:\
*.tgz=:\
*.arc=:\
*.arj=:\
*.taz=:\
*.lha=:\
*.lz4=:\
*.lzh=:\
*.lzma=:\
*.tlz=:\
*.txz=:\
*.tzo=:\
*.t7z=:\
*.zip=:\
*.z=:\
*.dz=:\
*.gz=:\
*.lrz=:\
*.lz=:\
*.lzo=:\
*.xz=:\
*.zst=:\
*.tzst=:\
*.bz2=:\
*.bz=:\
*.tbz=:\
*.tbz2=:\
*.tz=:\
*.deb=:\
*.rpm=:\
*.jar=:\
*.war=:\
*.ear=:\
*.sar=:\
*.rar=:\
*.alz=:\
*.ace=:\
*.zoo=:\
*.cpio=:\
*.7z=:\
*.rz=:\
*.cab=:\
*.wim=:\
*.swm=:\
*.dwm=:\
*.esd=:\
*.jpg=:\
*.jpeg=:\
*.mjpg=:\
*.mjpeg=:\
*.gif=:\
*.bmp=:\
*.pbm=:\
*.pgm=:\
*.ppm=:\
*.tga=:\
*.xbm=:\
*.xpm=:\
*.tif=:\
*.tiff=:\
*.png=:\
*.svg=:\
*.svgz=:\
*.mng=:\
*.pcx=:\
*.mov=:\
*.mpg=:\
*.mpeg=:\
*.m2v=:\
*.mkv=:\
*.webm=:\
*.ogm=:\
*.mp4=:\
*.m4v=:\
*.mp4v=:\
*.vob=:\
*.qt=:\
*.nuv=:\
*.wmv=:\
*.asf=:\
*.rm=:\
*.rmvb=:\
*.flc=:\
*.avi=:\
*.fli=:\
*.flv=:\
*.gl=:\
*.dl=:\
*.xcf=:\
*.xwd=:\
*.yuv=:\
*.cgm=:\
*.emf=:\
*.ogv=:\
*.ogx=:\
*.aac=:\
*.au=:\
*.flac=:\
*.m4a=:\
*.mid=:\
*.midi=:\
*.mka=:\
*.mp3=:\
*.mpc=:\
*.ogg=:\
*.ra=:\
*.wav=:\
*.oga=:\
*.opus=:\
*.spx=:\
*.xspf=:\
*.pdf=:\
*.nix=:\
"

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
# History with datetime and use fzf to search then copy to clipboard
# abbr hc "history --show-time=\"%Y-%m-%d %H:%M:%S \" | fzf --exact | cut -d ' ' -f 3- | xclip -selection clipboard"
abbr hc "history --show-time=\"%Y-%m-%d %H:%M:%S \" | fzf --exact | cut -d ' ' -f 3- | wl-copy"


#--------------------------------------------------------
# `bat` related
#--------------------------------------------------------
abbr fzf "fzf --preview \"bat --color=always --style=numbers --line-range=:500 {}\""


#--------------------------------------------------------
# Tensorflow
#--------------------------------------------------------
# set --export LD_LIBRARY_PATH /home/wison/Downloads/tensorflow/lib $LD_LIBRARY_PATH
# set --export LIBRARY_PATH /home/wison/Downloads/tensorflow/lib $LIBRARY_PATH

#--------------------------------------------------------
# Pytorch/Libtorch
#--------------------------------------------------------
# set --export LD_LIBRARY_PATH ~/Downloads/libtorch/lib $LD_LIBRARY_PATH


#--------------------------------------------------------
# emacs
#--------------------------------------------------------
abbr es "emacs --daemon --debug-init"
abbr kes "emacsclient -e \(\"kill-emacs\"\)"
abbr et "emacs --no-window-system"
abbr eg "emacs &"


#--------------------------------------------------------
# Hyprland
#--------------------------------------------------------
abbr hpc "nvim ~/.config/hypr/hyprland.conf"
abbr hpm "hyprctl monitors all"
abbr exith "hyprctl dispatch exit"
abbr cwp "swww img --transition-type wipe --transition-angle 45 ~/Photos/wallpaper/"


#--------------------------------------------------------
# MPV realted
#--------------------------------------------------------
abbr mpvh "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=ytdl"   # Best video and audio quality
abbr mpv  "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=best"   # Middle video and audio quality
abbr mpvl "mpv --ytdl --script-opts=try_ytdl_first=yes --ytdl-format=worst"  # Low video and audio quality


#--------------------------------------------------------
# Youtube download related
#--------------------------------------------------------
abbr yda "yt-dlp -f ba "
