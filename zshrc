# 自動補完
autoload -U compinit
compinit

# 補完時に大文字小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# プロンプト
autoload -U promptinit
promptinit
PROMPT="%n@%F{cyan}%m%f>"
RPROMPT="%F{yellow}%~%f"

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
HISTSIZE=256
SAVEHIST=256

# ディレクトリ名だけでcd
setopt auto_cd

# cdした先のディレクトリをディレクトリスタックに追加
# cd <Tab>でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd
setopt pushd_ignore_dups

# 履歴から同じコマンドを削除
setopt hist_ignore_all_dups

# デフォルトのエディタ
export EDITOR=vim

# lsを見やすくする
alias ls="ls -F --color"

# nvmコマンドの設定
if [[ -s ~/.nvm/nvm.sh ]];
then source ~/.nvm/nvm.sh
fi
