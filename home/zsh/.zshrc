# Interaktív shell. Prezto nélkül, kézzel: csak az van benne, amit használunk.
# Részek: prompt.zsh (prompt), aliases.zsh (aliasok), plugins/ (3 submodule).
# Mérés:  time zsh -il -c exit      Profil:  ZPROF=1 zsh -i -c exit

[[ -n $ZPROF ]] && zmodload zsh/zprof

ZSH_HOME=${${(%):-%x}:A:h}   # ennek a fájlnak a mappája (symlinken át is)

# --- viselkedés ------------------------------------------------------------------
setopt auto_cd auto_pushd pushd_ignore_dups pushd_silent pushd_to_home cdable_vars
setopt extended_glob interactive_comments rc_quotes combining_chars
setopt long_list_jobs auto_resume no_bg_nice no_hup no_check_jobs
setopt correct           # elgépelt parancsnévnél rákérdez
setopt clobber           # a > felülírhat létező fájlt (a noclobber többet ártott, mint használt)
setopt no_flow_control   # a Ctrl+S / Ctrl+Q ne fagyassza le a terminált
[[ -t 0 ]] && stty -ixon 2>/dev/null

# --- history ---------------------------------------------------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history share_history hist_verify hist_ignore_space
setopt hist_ignore_dups hist_ignore_all_dups hist_save_no_dups hist_find_no_dups hist_expire_dups_first

# --- completion ------------------------------------------------------------------
# A dump gépenként és zsh verziónként külön van (közös NFS home!), és naponta egyszer épül újra;
# egyébként ellenőrzés nélkül töltjük be (-C), ez a gyors.
setopt complete_in_word always_to_end path_dirs auto_menu auto_list no_menu_complete
zmodload zsh/complist
autoload -Uz compinit
() {
  local cache=${XDG_CACHE_HOME:-$HOME/.cache}/zsh
  [[ -d $cache ]] || mkdir -p $cache
  local dump=$cache/zcompdump-$HOST-$ZSH_VERSION
  if [[ -n $dump(#qN.mh-20) ]]; then
    compinit -C -d $dump
  else
    compinit -d $dump
    touch $dump
  fi
  zstyle ':completion::complete:*' use-cache on
  zstyle ':completion::complete:*' cache-path $cache/zcompcache-$HOST
}
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'
zstyle ':completion:*:warnings' format '%F{red}-- nincs találat --%f'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'

# --- billentyűk (emacs mód) ----------------------------------------------------------
bindkey -e
WORDCHARS='*?_-.[]~&;!#$%^(){}<>'   # a / és az = szóhatár: Ctrl+W útvonalnál csak egy elemet töröl

autoload -Uz edit-command-line
zle -N edit-command-line

_prepend_sudo() {
  [[ $BUFFER != 'sudo '* ]] && BUFFER="sudo $BUFFER" && (( CURSOR += 5 ))
}
zle -N _prepend_sudo

() {
  local k
  for k in '^[[H' '^[OH' '^[[1~'; do bindkey $k beginning-of-line; done     # Home
  for k in '^[[F' '^[OF' '^[[4~'; do bindkey $k end-of-line; done           # End
  for k in '^[[1;5D' '^[[5D' '^[Od'; do bindkey $k backward-word; done      # Ctrl+←
  for k in '^[[1;5C' '^[[5C' '^[Oc'; do bindkey $k forward-word; done       # Ctrl+→
}
bindkey '^[[3~' delete-char                 # Delete
bindkey '^[[2~' overwrite-mode              # Insert
bindkey '^[[Z'  reverse-menu-complete       # Shift+Tab
bindkey ' '     magic-space                 # szóköz: !! és társai kibontása
bindkey '^R'    history-incremental-pattern-search-backward
bindkey '^Q'    push-line-or-edit           # félretesz egy félkész parancsot
bindkey '^X^E'  edit-command-line           # a parancs szerkesztése $EDITOR-ban
bindkey '^X^S'  _prepend_sudo               # sudo a sor elejére
bindkey -M menuselect '^[[Z' reverse-menu-complete

# --- prompt, aliasok -----------------------------------------------------------------
source $ZSH_HOME/prompt.zsh
source $ZSH_HOME/aliases.zsh

# --- eszközök (csak ha vannak) --------------------------------------------------------
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# command-not-found: megmondja, melyik csomagban van a hiányzó parancs (Arch: pkgfile, Debian)
for _f in /usr/share/doc/pkgfile/command-not-found.zsh /etc/zsh_command_not_found; do
  [[ -r $_f ]] && source $_f && break
done
unset _f

# nvm: lustán — a betöltése ~175 ms volt minden shell indulásnál. Az első nvm/node hívásig
# a rendszer node-ja (vagy ami a PATH-on van) megy; az "nvm" parancs első használatkor tölt be.
if [[ -s $NVM_DIR/nvm.sh ]]; then
  nvm() {
    unfunction nvm
    source $NVM_DIR/nvm.sh
    [[ -s $NVM_DIR/bash_completion ]] && source $NVM_DIR/bash_completion
    nvm "$@"
  }
fi

# conda: ugyanígy lustán (a hook minden indulásnál egy pythont indított).
# FIGYELEM: így a base env nem aktiválódik magától — "conda activate" kell hozzá.
if [[ -x /usr/bin/conda ]]; then
  conda() {
    unfunction conda
    eval "$(/usr/bin/conda shell.zsh hook 2>/dev/null)"
    conda "$@"
  }
fi

# ssh-agent: ha nincs (pl. továbbított) agent, gépenként egy közöset használunk, és betöltjük
# az alap kulcsokat. Ahol nincs ilyen kulcsfájl (szerverek), ott nem csinál semmit.
() {
  [[ -S $SSH_AUTH_SOCK ]] && return
  (( $+commands[ssh-agent] )) || return
  local keys=($HOME/.ssh/{id_rsa,id_rsa2,id_github}(N))
  (( $#keys )) || return

  export SSH_AUTH_SOCK=${XDG_RUNTIME_DIR:-/tmp}/ssh-agent-$UID.sock
  ssh-add -l &>/dev/null
  local rc=$?
  if (( rc == 2 )); then            # 2 = nem érhető el az agent: indítunk egyet
    command rm -f $SSH_AUTH_SOCK
    ssh-agent -a $SSH_AUTH_SOCK >/dev/null
    rc=1
  fi
  # 1 = fut, de üres: kulcsok be (jelszavas kulcsnál itt kérdez rá, egyszer)
  (( rc == 1 )) && [[ -t 0 ]] && ssh-add $keys 2>/dev/null
}

# --- pluginek (a sorrend számít: a syntax-highlighting a végén, a substring-search utána) ---
# Ha a submodule-ok nincsenek letöltve (git submodule update --init), plugin nélkül is megy minden.
_plugin() {
  local file=$ZSH_HOME/plugins/$1/$1.zsh
  [[ -r $file ]] && source $file
}

ZSH_AUTOSUGGEST_MANUAL_REBIND=1
_plugin zsh-autosuggestions

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
if _plugin zsh-syntax-highlighting; then
  ZSH_HIGHLIGHT_STYLES[builtin]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
  ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
fi

if _plugin zsh-history-substring-search; then
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=
  for _k in '^[[A' '^[OA' '^P'; do bindkey $_k history-substring-search-up; done     # ↑
  for _k in '^[[B' '^[OB' '^N'; do bindkey $_k history-substring-search-down; done   # ↓
  unset _k
fi
unfunction _plugin

if [[ -n $ZPROF ]]; then zprof; fi
true   # az első prompt ne mutasson hibakódot egy fenti, nem teljesülő feltétel miatt
