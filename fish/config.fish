# vim: ft=fish
set --export CLICOLOR "xterm-color"
set --export LSCOLORS "gxfxcxdxbxegedabagacad"
set --export EDITOR nvim

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
    set_color ACE6FE
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
    end
    
    set_color ACE6FE
    echo -en " > "
    echo -en $cpu_info
    set_color normal
end

function show_network_info -d "Prints information about network"
    set --local os_type (uname -s)

    if [ $os_type = "Linux" ]
        set --local ip (ip address show | grep -E "inet .* brd .* dynamic" | cut -d " " -f6)
        set --local gw (ip route | grep default | cut -d " " -f3)
        set network_info "IP: $ip, Default gateway: $gw"
    else if [ $os_type = "Darwin" ]
        set --local ip (ifconfig | grep -v "127.0.0.1" | grep "inet " | head -1 | cut -d " " -f2)
        set --local gw (netstat -nr | grep -E "default.*UGSc" | cut -d " " -f13)
        set network_info "IP: $ip, Default gateway: $gw"
    end

    set_color ACE6FE
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
    set_color A4E199 --bold
    printf " %s | " "$USER"

    # set_color E66B17 --bold
    # set_color bf4300 --bold
    set_color ACE6FE --bold

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
bind -M insert -m default hh backward-char force-repaint
bind -M insert \t accept-autosuggestion
bind -M default e history-search-backward
bind -M default n history-search-forward

#--------------------------------------------------------
# SSR server login related
#--------------------------------------------------------
alias sshToOldSSR-Server="ssh -i ~/.ssh/ssr-server wisonssr@35.236.167.115"
alias sshToMySSR-Server="ssh -i ~/.ssh/ssr-server wisonye_ssr@35.236.162.70"
alias sshToTTProductionServerAliUsWest="ssh -i /Users/wison/UpWorkProject/LiuGang_Project/documentation/Ali-deployment/ali-us-west-server-ssh-key.pem root@gis.totarget.net"
alias sshToTTProductionServerAliCnShangHai="ssh -i /Users/wison/UpWorkProject/LiuGang_Project/documentation/Ali-deployment/ali-cn-shanghai-server-ssh-key.pem root@gis.ttrfid.com"
alias sshToTkcareServer="ssh -p 28595 root@172.96.218.209"
alias sshToRaspberryPi4="ssh ubuntu@192.168.1.100"
alias sshToRaspberryPi4Wifi="ssh ubuntu@192.168.1.108"

#--------------------------------------------------------
# ~/my-shell
#--------------------------------------------------------
set PATH ~/my-shell ~/my-shell/google-cloud-sdk/bin $PATH

# Clear console
abbr c "clear"

# History
abbr h "history -n40"

# Abbreviation for `exa` and map `ll` and
abbr exal "exa --long --git --time-style=long-iso --sort=newest"
# abbr ll "exa --long --git --time-style=long-iso --sort=newest"
abbr exalr "exa --long --git --time-style=long-iso --sort=newest -r"
# abbr llr "exa --long --git --time-style=long-iso --sort=newest -r"
abbr ll "ls -lht"
abbr llt "exa --long --git --time-style=long-iso --sort=newest -r --tree"

# Abbreviation for `dust` and map it to `du`
# Make sure you already install it by running: cargo install du-dust
abbr du "dust -d1"
abbr ps "procs"

# Abbreviation for `Docker
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

# Vi config related and vifm
# abbr vim "nvim"
# abbr fc "nvim ~/.config/fish/config.fish"
# abbr vc "nvim ~/.config/nvim/init.vim"
abbr vim "nvim"
abbr fc "nvim ~/.config/fish/config.fish"
abbr vc "cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
abbr vifm "vifm -c 'colorscheme zenburn_1' -c view"

# Git related
abbr gs "git status"
abbr gb "git branch"
abbr gl "git log -n10 --oneline --decorate --all --graph"
abbr ga "git add"
abbr gf "git diff HEAD | bat"
abbr gc "git commit -nm"
abbr gp "git push -u origin"
abbr gck "git checkout"

# Code-insider
abbr ci "code-insiders ."

# Rust related
abbr cn "cargo new"
abbr cc "cargo check"
abbr cr "cargo run"
abbr ct "cargo test"
abbr cw "cargo watch"
abbr cwr "cargo watch -c --exec run"
abbr cwt "cargo watch -c --exec 'test -- --nocapture'"

# Alacritty
abbr al "/Applications/Alacritty.app/Contents/MacOS/alacritty --working-directory ./ &"
abbr ac "nvim ~/.alacritty.yml"

# Tmux
abbr tr "tmux source-file ~/.tmux.conf"
abbr tn "tmux new -s dev"
abbr tc "nvim ~/.tmux.conf"
abbr tl "tmux ls"
abbr ta "tmux attach-session -t 0"
abbr ta "tmux attach-session -t dev"
abbr tab "tmux attach-session -t 'Dropit Backend Dev'"
abbr tal "tmux attach-session -t 'Dropit Live-Auction-App Dev'"
abbr tav "tmux attach-session -t 'Dropit Vendor Service'"
abbr taa "tmux attach-session -t 'Dropit Admin App Shopify'"
abbr taf "tmux attach-session -t 'Fion workflow'"
abbr tk "tmux kill-server"
abbr rvs "GOOGLE_APPLICATION_CREDENTIALS=./vendor_service_key.json IS_EMULATOR=true PORT=6801 PROJECT_ID=(gcloud config get-value project) LOG_LEVEL=DEBUG DEBUG_LOG_REQUEST_BODY=true DEBUG_LOG_VENDOR=true DEBUG_LOG_GET_VENDOR_SETTINGS=true DEBUG_LOG_UPDATE_STYLE_SETTINGS=true DEBUG_LOG_SHOPIFY_CURRENCY=true CARGO_NET_GIT_FETCH_WITH_CLI=true ./target/debug/vendor_service"

# `wasm-pack`
abbr wp "wasm-pack"

# iproute2 related
abbr ip "ip"
abbr ipj "ip --json"

# iproute2 related: Net status
# nst - net status tcp all
# nsu - net status udp all
# nstl - net status tcp listening
# abbr ns "ss"
abbr nst "lsof -nP -iTCP"
abbr nstl "lsof -nP -iTCP | grep LISTEN"
abbr nsu "lsof -nP -iUDP"

# Shopify CLI
abbr sh "shopify"

# Kubernetes
abbr kb "kubectl"

abbr kcd "kubectl create deployment"
abbr ked "kubectl edit deployment"
abbr kdd "kubectl delete deployment"

abbr kgn "kubectl get node --output=wide"
abbr kgd "kubectl get deployment --output=wide"
abbr kgr "kubectl get replicaset --output=wide"
abbr kgp "kubectl get pod --output=wide"
abbr kgs "kubectl get service --output=wide"
abbr kga "kubectl get all --output=wide"
abbr kgns "kubectl get namespace"

# Firebase
abbr fb "firebase"
abbr fbe "firebase emulators:start"

# Yabai, skhd and limelight config
abbr yc "nvim ~/.config/yabai/yabairc"
abbr sc "nvim ~/.config/skhd/skhdrc"
abbr lc "nvim ~/.config/limelight/limelightrc"

# Neofetch
abbr nf "neofetch"

# Screen saver
abbr ss "rusty-rain --color 172,230,254 --shade --chars bin --head 255,175,64"

# Python 2 -> 3
abbr python "python3"


# Google Cloud SDK
abbr g "gcloud"
abbr gi "gcloud info"
abbr gal "gcloud auth list"
abbr gcl "gcloud config list"


#--------------------------------------------------------
# Node LTS
#--------------------------------------------------------
#set PATH /usr/local/opt/node@10/bin $PATH
#set LDFLAGS -L/usr/local/opt/node@10/lib
#set CPPFLAGS -I/usr/local/opt/node@10/include

set PATH /usr/local/opt/node@14/bin $PATH
set LDFLAGS -L/usr/local/opt/node@14/lib
set CPPFLAGS -I/usr/local/opt/node@14/include

#--------------------------------------------------------
# GO LANG
#--------------------------------------------------------
# set GOPATH $HOME/go
# set PATH $PATH $GOPATH/bin

#--------------------------------------------------------
# Rust - Cargo
#--------------------------------------------------------
set PATH $HOME/.cargo/bin $PATH
set LD_LIBRARY_PATH (rustc --print sysroot)"/lib"
set RUST_SRC_PATH (rustc --print sysroot)"/lib/rustlib/src/rust/library"

#--------------------------------------------------------
# For Rust cross compilation
#
# brew install FiloSottile/musl-cross/musl-cross
# 
# gmake install TARGET=x86_64-linux-musl
#--------------------------------------------------------
set PATH /usr/local/opt/gnu-sed/libexec/gnubin $PATH

#--------------------------------------------------------
# Fuzzy file searching pluging for `vim`
#--------------------------------------------------------
set PATH ~/.vim/plugged/fzf/bin $PATH
set --export FZF_DEFAULT_COMMAND 'fd --type f'
set --export FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND

#--------------------------------------------------------
# Python 3.7
#--------------------------------------------------------
set PATH /usr/local/opt/python@3.7/bin $PATH

#--------------------------------------------------------
# Google protocol buffer binary
#--------------------------------------------------------
set PATH ~/UpWorkProject/LiuGang_Project/documentation/Binary-Protoocl/protoc-4.0.0-rc-1-osx-x86_64/bin $PATH

#--------------------------------------------------------
# OpenSSL 1.1 (installed via `brew install vim`)
#--------------------------------------------------------
# set PATH /usr/local/opt/openssl@1.1/bin $PATH
# set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

#--------------------------------------------------------
# Ruby (installed via `brew install vim`)
#--------------------------------------------------------
# set -gx LDFLAGS "-L/usr/local/opt/ruby/lib"
# set -gx CPPFLAGS "-I/usr/local/opt/ruby/include"

#--------------------------------------------------------
# Open JDK 11
#--------------------------------------------------------
set PATH /usr/local/opt/openjdk@11/bin $PATH

#--------------------------------------------------------
# QEMU(ARM) for STM32F4
#--------------------------------------------------------
set PATH /Users/wison/Library/xPacks/qemu-arm/2.8.0-9/bin $PATH

#--------------------------------------------------------
# OpenCV (install via 'brew install opencv')
#--------------------------------------------------------
set --export DYLD_FALLBACK_LIBRARY_PATH (xcode-select --print-path)/usr/lib

#--------------------------------------------------------
# Wasmtime
#--------------------------------------------------------
set -gx WASMTIME_HOME "$HOME/.wasmtime"
string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH


#--------------------------------------------------------
# Google Cloud SDK
#--------------------------------------------------------
if [ -f '/Users/wison/my-shell/google-cloud-sdk/path.fish.inc' ]; . '/Users/wison/my-shell/google-cloud-sdk/path.fish.inc'; end


#--------------------------------------------------------
# `lf` file manager icons settings
#--------------------------------------------------------
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
# Backup script and restore
#--------------------------------------------------------
abbr backupVimrc "cp -rvf ~/.vimrc ~/my-shell/backup/vim/vimrc"
abbr backupNvimrc "cp -rvf ~/.config/nvim/init.vim ~/my-shell/backup/vim/init.vim"
abbr backupNvimrcLua "cp -rvf ~/.config/nvim/* ~/my-shell/backup/vim_lua/"
abbr backupCocConfig "cp -rvf ~/.config/nvim/coc-settings.json ~/my-shell/backup/vim/coc-settings.json"
abbr backupFishConfig "cp -rvf ~/.config/fish/config.fish ~/my-shell/backup/fish/config.fish"
abbr backupCocSnippets "cp -rvf ~/.config/coc/ultisnips ~/my-shell/backup/vim/"
abbr backupAlacritty "cp -rvf ~/.alacritty.yml ~/my-shell/backup/alacritty/alacritty.yml"
abbr backupTmux "cp -rvf ~/.tmux.conf ~/my-shell/backup/tmux/tmux.conf && cp -rvf ~/.tmux_line ~/my-shell/backup/tmux/tmux_line"

abbr restoreVimrc "cp -rvf ~/my-shell/backup/vim/vimrc ~/.vimrc"
abbr restoreNvimrc "cp -rvf ~/my-shell/backup/vim/init.vim ~/.config/nvim/init.vim"
abbr restoreNvimrcLua "cp -rvf ~/my-shell/backup/vim_lua/* ~/.config/nvim/ "
abbr restoreCocConfig "cp -rvf ~/my-shell/backup/vim/coc-settings.json ~/.config/nvim/coc-settings.json"
abbr restoreFishConfig "cp -rvf ~/my-shell/backup/fish/config.fish ~/.config/fish/config.fish"
abbr restoreCocSnippets "cp -rvf ~/my-shell/backup/vim/ultisnips ~/.config/coc/"
abbr restoreAlacritty "cp -rvf ~/my-shell/backup/alacritty/alacritty.yml ~/.alacritty.yml"
abbr restoreTmux "cp -rvf ~/my-shell/backup/tmux/tmux.conf ~/.tmux.conf && cp -rvf ~/my-shell/backup/tmux/tmux_line ~/.tmux_line"
