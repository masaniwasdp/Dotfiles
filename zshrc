# 自動補完
autoload -U compinit
compinit

# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# シンタックスハイライティング
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# プロンプト
autoload -U promptinit
promptinit
PROMPT="%F{yellow}%T%f %F{blue}%n>%f "
RPROMPT="%F{red}%~%f"

# ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
       echo -ne "\033]0;${USER}@${HOST%%.*}\007"
    }
    ;;
esac

# 他のターミナルとヒストリを共有
setopt share_history

# ヒストリを保存
HISTFILE=~/.zsh_history
HISTSIZE=512
SAVEHIST=512

# ディレクトリ名だけでcd
setopt auto_cd

# ディレクトリスタック
setopt auto_pushd
setopt pushd_ignore_dups

# 履歴から同じコマンドを削除
setopt hist_ignore_all_dups

# デフォルトのエディタ
export EDITOR=vim

# デフォルトのコンパイラ
export CC=clang
export CXX=clang++

# ls
alias ls="ls -l -F --color"

# Webカメラ
export LD_PRELOAD=/usr/lib/libv4l/v4l2convert.so

# dubimport
alias dubimport="~/DUBImport/build/dubimport"
