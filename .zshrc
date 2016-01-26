ZSH=$HOME/.config/oh-my-zsh
ZSH_THEME="agnoster"

plugins=(git adb archlinux common-aliases cp zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

typeset -U path
path=(~/bin /opt/android-sdk/tools /opt/android-sdk/platform-tools $path)

bindkey "^[[H" beginning-of-line
bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[F" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward
