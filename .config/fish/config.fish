if status is-interactive
  # Commands to run in interactive sessions can go here
  set fish_greeting
  starship init fish | source
end

function prefix_line
  set -l cmd (commandline)
  set -l line (commandline -L)
  set cmd[$line] "$argv $cmd[$line]"
  commandline -r $cmd
end
function bind_bang
  switch (commandline -t)[-1]
    case "!"
       commandline -t -- $history[1]
       commandline -f repaint
    case "*"
       commandline -i !
  end
end

function bind_dollar
  switch (commandline -t)[-1]
    case "!"
      commandline -f backward-delete-char history-token-search-backward
    case "*"
      commandline -i '$'
  end
end
bind ! bind_bang
bind '$' bind_dollar
bind \ct 'prefix_line sudo'

set -gx EDITOR 'nvim'
set -gx VISUAL 'nvim'

set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache
set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh

set -x ANDROID_HOME $XDG_DATA_HOME/android
set -x HISTFILE $XDG_STATE_HOME/bash/history
set -x CARGO_HOME $XDG_DATA_HOME/cargo
set -x DISTCC_DIR $XDG_CONFIG_HOME/distcc
set -x DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -x GNUPGHOME $XDG_DATA_HOME/gnupg
set -x GRADLE_USER_HOME $XDG_DATA_HOME/gradle
set -x ICEAUTHORITY $XDG_CACHE_HOME/ICEauthority
set -x XCOMPOSEFILE $XDG_CONFIG_HOME/X11/xcompose
set -x NODE_REPL_HISTORY $XDG_DATA_HOME/node_repl_history
set -x NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/npmrc
set -x PYTHONSTARTUP $XDG_CONFIG_HOME/python/pythonrc
set -x RUSTUP_HOME $XDG_DATA_HOME/rustup
set -x TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
set -x WINEPREFIX $XDG_DATA_HOME/wine
set -x ELECTRON_OZONE_PLATFORM_HINT auto
set -x MOZ_ENABLE_WAYLAND 1

set -x SWWW_TRANSITION_FPS 60
set -x SWWW_TRANSITION any
set -x SWWW_TRANSITION_DURATION 1
# set -x GTK_IM_MODULE 'wayland'
set -x QT_IM_MODULE 'fcitx'
set -x XMODIFIERS '@im=fcitx'

zoxide init fish | source
alias cd 'z'
alias s 'kitten ssh'
alias cl 'clear'
alias ls 'lsd'
alias l 'ls'
alias la 'ls -al'
alias ll 'ls -l'
alias lr 'ls -R'
alias hx 'helix'
alias se 'sudoedit'
alias wget 'wget --hsts-file="$XDG_DATA_HOME/wget-hsts"'
alias blctl 'bluetoothctl'
alias bltui 'bluetuith'
alias neofetch 'fastfetch'
alias dots='git --git-dir="$HOME/dots/" --work-tree="$HOME"'

function compress --description 'compress <folder> <output>'
    tar cf - $argv[1] -P | pv -s $(du -sb $argv[1] | awk '{print $1}') | gzip > $argv[2]
end

fish_add_path "$HOME/bin"
fish_add_path "$HOME/.npm-global/bin"
fish_add_path "$HOME/.local/bin"
fish_add_path "/opt/microchip/xc16/v2.10/bin"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
