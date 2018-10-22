ZSH=$HOME/.dotfiles/Zsh/oh-my-zsh
ZSH_THEME="agnoster"

plugins=(git adb archlinux common-aliases cp catimg laravel symfony2)

source $ZSH/oh-my-zsh.sh

typeset -U path
path=(~/.Bin ~/Work/_Android_/Sdk/tools/ ~/Work/_Android_/Sdk/tools/bin/ ~/Work/_Android_/Sdk/platform-tools/ ~/.composer/vendor/bin ~/.yarn/bin $path)

bindkey "^[[H" beginning-of-line
bindkey "^[[2~" overwrite-mode
bindkey "^[[3~" delete-char
bindkey "^[[F" end-of-line
bindkey "^[[5~" history-beginning-search-backward
bindkey "^[[6~" history-beginning-search-forward

function gitdiff() {
    git diff --no-ext-diff -w "$@" | vim -R -
}
function kepmegosztas() {
    x11vnc -viewonly -display :0 -noxwarppointer -forever -loop -shared -clip 1920x1080+1920+0 -cursor most -nopw -ncache 10 -ncache_cr -nobell -noxdamage -noxfixes -noxrecord -scale $@ -noncache -xrandr -noclipboard -norc
}
function kepmegosztasjo() {
    x11vnc -display :0 -noxwarppointer -multiptr -forever -loop -shared -clip 1920x1080+1920+0 -nopw -ncache 10 -ncache_cr -nobell -noxdamage -noxfixes -noxrecord -scale 1776x1000 -noncache -xrandr -noclipboard -norc -scale_cursor 1 -nolookup -nossl -input M,M
}
function gitall() {
    git add .
    if [ "$1" != "" ]
    then
        git commit -m "$1"
    else
        git commit -m update # default commit message is `update`
    fi
    git push origin HEAD
}
alias kepmegosztashd="kepmegosztas 1776x1000"
alias kepmegosztasld="kepmegosztas 1280x720"
#alias mondd='espeak -vhu+f2'
alias mondd='espeak -vhu'
alias midi='fluidsynth -a alsa -i /usr/share/soundfonts/FluidR3_GM2-2.sf2'
alias artisan="php artisan"
alias gg="git pull && git push"
alias kiafasztamad="sudo netstat -ntu | awk '{print $5}' | grep -iv \"[address|server]\" | grep -v ::1 | grep -v 127.0.0.1 | grep -v 10.0. | cut -d: -f1 | sort | uniq -c | sort -n"
alias muzsika="curl -sLN http://ai-radio.org/320.opus | opusdec - - | aplay -qfdat"
alias gitupdate='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done)'
alias pp='ps uxaf | most'
alias ffs='sudo `fc -n -l -1`'
alias randomscreen='hexdump -C < /dev/urandom | grep "ca fe"'
alias pd='popd'
alias gitkurvanagyfileok="git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr($0,6)}' | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"
alias helyfoglalas='du -cha --max-depth=1 / | grep -E "M|G"'
alias icat='kitty +kitten icat'

#Magyar bill wayland alatt
export XKB_DEFAULT_LAYOUT=hu
#Sötét GTK téma
#export GTK_THEME=Adwaita:dark

export ANDROID_HOME=/home/bayi/Work/_Android_/Sdk
export XDG_CURRENT_DESKTOP=GNOME

export EDITOR=vim
export PAGER=most
export TERMINAL=kitty

# Ctrl+S -re ne csinaljon semmit a terminal
stty -ixon

# Oh my zsh betöltése
source ~/.dotfiles/Zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
