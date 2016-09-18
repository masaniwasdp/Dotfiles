autoload -U compinit promptinit

compinit

promptinit
prompt walters
prompt="%n@%F{cyan}$(hostname)%f>"

alias ls="ls -GF --color"
