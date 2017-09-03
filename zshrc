source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

function set_prompt() {
    autoload -U promptinit

    promptinit

    PROMPT=" %F{red}%B%n%b%f %B>%b "
    RPROMPT="%F{yellow}[%~]%f "
}

function set_title() {
    case "${TERM}" in
        kterm* | xterm)
            precmd() { echo -ne "\033]0;${USER}@${HOST%%.*}\007" }
            ;;
    esac
}

function set_completion() {
    autoload -U compinit

    compinit

    zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"
}

function set_history() {
    setopt share_history
    setopt hist_ignore_all_dups

    HISTFILE="~/.zsh_history"
    HISTSIZE=512
    SAVEHIST=512
}

function set_cd() {
    setopt auto_cd
    setopt auto_pushd
    setopt pushd_ignore_dups
}

function set_variables() {
    export LD_PRELOAD="/usr/lib/libv4l/v4l2convert.so"
    export CC="clang"
    export CXX="clang++"
    export EDITOR="vim"
}

function set_aliases() {
    alias desktopdial="~/bin/DesktopDial/desktopdial"
    alias dubimport="~/bin/DUBImport/dubimport"
    alias ls="ls -l -F --color"
}

set_prompt
set_title
set_completion
set_history
set_cd
set_variables
set_aliases
