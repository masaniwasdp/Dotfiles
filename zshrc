# Sintakso reliefigi
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Prompto
autoload -U promptinit

promptinit

PROMPT=" %F{red}%B%n%b%f %B>%b "
RPROMPT="%F{yellow}[%~]%f "

# Titolo
case "${TERM}" in
    kterm* | xterm)
        precmd() { echo -ne "\033]0;${USER}@${HOST%%.*}\007" }
        ;;
esac

# Kompletigo
autoload -U compinit

compinit

zstyle ":completion:*" matcher-list "m:{a-z}={A-Z}"

# Historio
setopt share_history
setopt hist_ignore_all_dups

HISTFILE="/home/masaniwa/.zsh_history"
HISTSIZE=512
SAVEHIST=512

# cd
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups

# Variabloj
export PATH=$PATH:"/home/masaniwa/.local/bin"
export LD_PRELOAD="/usr/lib/libv4l/v4l2convert.so"
export CC="clang"
export CXX="clang++"
export EDITOR="vim"

# Aliasoj
alias ghclone="/home/masaniwa/ghclone.sh"
alias ls="ls -l -F --color"
