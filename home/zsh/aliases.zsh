# Aliasok és apró függvények. Ami egy programtól függ, csak akkor jön létre, ha a program megvan.

# --- ls ------------------------------------------------------------------------
if (( $+commands[eza] )); then
  alias ls='eza' ll='eza -alh' tree='eza --tree'
elif (( $+commands[exa] )); then
  alias ls='exa' ll='exa -alh' tree='exa --tree'
else
  alias ls='ls --color=auto' ll='ls -alh'
fi
alias l='ls -1a'
alias la='ll'

# --- alap parancsok --------------------------------------------------------------
alias grep='grep --color=auto'
alias mkdir='mkdir -p'
alias df='df -kh'
alias du='du -kh'
alias type='type -a'
alias vim='nvim'
alias _='sudo'
alias d='dirs -v'
alias cpd='popd'
alias -- -='cd -'

# ezeknél a * és ? menjen át a programnak, ne a shell bontsa ki (find . -name *.txt, scp host:*.log .)
alias find='noglob find'
alias scp='noglob scp'
alias sftp='noglob sftp'
alias rsync='noglob rsync'
alias locate='noglob locate'
alias history='noglob history'
alias fc='noglob fc'

# Felülírás elleni védelem: cp és mv rákérdez, ha létező fájlt írna felül.
# Csak embernek: Claude Code shelljében (CLAUDECODE) és scriptekben nincs, ott csak megakasztana.
if [[ -t 0 && -z $CLAUDECODE ]]; then
  alias cp='cp -i'
  alias mv='mv -i'
fi

(( $+commands[rg]   )) && alias rgrep='rg'
(( $+commands[btop] )) && alias top='btop -u 100'
(( $+commands[entr] )) && alias watch-c='find . -type f -regex ".*[ch]$" | entr make'

# --- fájltípus -> program (csak a fájlnevet beírva megnyitja) -----------------------
alias -s {php,txt,c,cpp,h,js,json}=nvim
alias -s {html,pdf}=chromium
alias -s {avi,mp4,3gp,wmv}=mpv
alias -s zip=file-roller

# --- számológép: "? 2+2" vagy "= 2+2" ----------------------------------------------
if (( $+commands[qalc] )); then
  function = {
    set -o localoptions -o noglob
    qalc -c \'"$@"\'
  }
  alias '?'='noglob ='
fi

# --- fejlesztés ------------------------------------------------------------------
alias artisan='php artisan'
alias tinker='php artisan tinker'
alias sf='php bin/console'
alias claude-wam='CLAUDE_CONFIG_DIR=~/.claude-wam claude'

# --- vegyes ----------------------------------------------------------------------
alias pp='ps uxaf'
alias ffs='sudo `fc -n -l -1`'
alias sa='alias | grep -i'
alias large-files='sudo du -cha --max-depth=1 | grep --color=always -E "[0-9]+(M|G)"'
alias http-serve='python3 -m http.server'
alias midi='fluidsynth -a alsa -i /usr/share/soundfonts/FluidR3_GM2-2.sf2'
alias random-screen='hexdump -e "64/1 \"%02x \" \"\n\"" < /dev/urandom'
alias random-pw='cat /dev/urandom | tr -dc A-Za-z0-9@_-_ | head -c 16; echo " "'

# --- git -------------------------------------------------------------------------
function git-diff-view() {
  git diff --no-ext-diff -w "$@" | nvim -R -
}
alias gg='git pull && git push'
alias git-log="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias git-tree='git log --all --decorate --oneline --graph --date=relative --abbrev-commit'
alias git-tree-long='git log --graph --abbrev-commit --decorate --date=relative --all'
alias git-graph='git graphviz --first-parent master  | xdot -'
alias git-update='(for l in `find . -name .git | xargs -i dirname {}` ; do cd $l; pwd; git pull; cd -; done)'
alias git-changed-files='git diff --name-only --relative'
alias git-large-files="git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | awk '/^blob/ {print substr(\$0,6)}' | sort --numeric-sort --key=2 | cut --complement --characters=13-40 | numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest"

# --- hálózat ---------------------------------------------------------------------
alias net-open-ports='sudo netstat -lnpt | grep --color=never -E "(tcp|udp)"'
alias net-open-connections='sudo netstat -ntu'
alias net-ddos-check="sudo netstat -ntu | awk '{print \$5}' | grep -iv \"[address|server]\" | grep -v ::1 | grep -v 127.0.0.1 | grep -v 10.0. | cut -d: -f1 | sort | uniq -c | sort -n"
