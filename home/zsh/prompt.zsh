# Kétsoros prompt, külső függőség és powerline font nélkül:
#
#   bayi@srv ~/Projektek/Private/HomeLab  main ±2 ?1 ↑1
#   ❯                                   (hiba után:  ✘130 ❯ )
#
# - user@host mindig látszik; a hosztnév színe gépenként más (a névből számolva), a root piros
# - a git branch azonnal megjelenik (fájlból olvassuk, nem fut hozzá git)
# - a dirty jelzők (± módosított, ? követetlen, ↑↓ előrébb/lemaradva) a háttérben jönnek,
#   így nagy repóban / NFS-en sem akad a prompt

setopt prompt_subst

# --- hosztszín: a hosztnévből, stabilan ---------------------------------------
() {
  local palette=(39 45 51 81 114 149 179 208 213 141 203 220)
  local -i h=0
  local c
  for c in ${(s::)HOST}; do
    (( h = (h * 31 + #c) % 100003 ))
  done
  typeset -g _prompt_host_color=$palette[$(( h % $#palette + 1 ))]
}

# --- git: gyökér és branch, fork nélkül ---------------------------------------
typeset -g _prompt_git_root= _prompt_git_branch= _prompt_git_extra=
typeset -g _prompt_git_fd=

_prompt_git_find() {
  local dir=$PWD gitdir head
  _prompt_git_branch=
  while [[ -n $dir ]]; do
    if [[ -e $dir/.git ]]; then
      gitdir=$dir/.git
      # worktree / submodule: a .git egy fájl, benne "gitdir: <út>"
      if [[ -f $gitdir ]]; then
        gitdir=${$(<$gitdir)#gitdir: }
        [[ $gitdir != /* ]] && gitdir=$dir/$gitdir
      fi
      if [[ -r $gitdir/HEAD ]]; then
        head=$(<$gitdir/HEAD)
        if [[ $head == 'ref: refs/heads/'* ]]; then
          _prompt_git_branch=${head#ref: refs/heads/}
        else
          _prompt_git_branch=${head[1,7]}   # detached HEAD: rövid hash
        fi
        _prompt_git_branch=${_prompt_git_branch//\%/%%}   # a % a promptban speciális
        # másik repóba léptünk: a régi dirty jelzők nem érvényesek
        [[ $dir != $_prompt_git_root ]] && _prompt_git_extra=
        _prompt_git_root=$dir
        return 0
      fi
    fi
    dir=${dir%/*}
  done
  _prompt_git_root= _prompt_git_extra=
  return 1
}

# --- git: dirty jelzők a háttérben ---------------------------------------------
_prompt_git_status() {
  local line
  local -i changed=0 untracked=0 ahead=0 behind=0
  command git --no-optional-locks status --porcelain=v2 --branch 2>/dev/null | while IFS= read -r line; do
    case $line in
      '# branch.ab '*) ahead=${${line#\# branch.ab +}%% *}; behind=${line##* -} ;;
      '? '*)           (( untracked++ )) ;;
      [12u]' '*)       (( changed++ )) ;;
    esac
  done
  local out=
  (( changed ))   && out+=" %F{yellow}±$changed%f"
  (( untracked )) && out+=" %F{244}?$untracked%f"
  (( ahead ))     && out+=" %F{cyan}↑$ahead%f"
  (( behind ))    && out+=" %F{magenta}↓$behind%f"
  print -r -- "$out"
}

_prompt_git_async_done() {
  local fd=$1 result
  IFS= read -r -u $fd result
  zle -F $fd
  exec {fd}<&-
  _prompt_git_fd=
  if [[ $result != $_prompt_git_extra ]]; then
    _prompt_git_extra=$result
    _prompt_git_render
    zle && zle reset-prompt
  fi
}

# a promptba kerülő git darab: "  branch ±2 ?1 ↑1", vagy üres, ha nem repóban vagyunk
typeset -g _prompt_git=
_prompt_git_render() {
  if [[ -n $_prompt_git_branch ]]; then
    _prompt_git="  %F{magenta}${_prompt_git_branch}%f${_prompt_git_extra}"
  else
    _prompt_git=
  fi
}

_prompt_git_async_start() {
  # az előző, még futó lekérdezés már nem érdekes
  if [[ -n $_prompt_git_fd ]]; then
    zle -F $_prompt_git_fd 2>/dev/null
    exec {_prompt_git_fd}<&-
    _prompt_git_fd=
  fi
  exec {_prompt_git_fd}< <(_prompt_git_status)
  zle -F $_prompt_git_fd _prompt_git_async_done
}

# --- összerakás ----------------------------------------------------------------
# ablakcímet csak olyan terminálnak küldünk, ami érti (a sima Linux konzol szemetet írna ki)
typeset -g _prompt_title=0
[[ $TERM == (xterm|alacritty|foot|rxvt|screen|tmux|kitty|wezterm)* ]] && _prompt_title=1

_prompt_precmd() {
  # ablakcím: user@host: mappa
  (( _prompt_title )) && print -Pn '\e]0;%n@%m: %~\a'

  if (( $+commands[git] )) && _prompt_git_find; then
    _prompt_git_async_start
  fi
  _prompt_git_render
}

_prompt_preexec() {
  # ablakcím futás közben: a parancs (vezérlőkarakterek nélkül)
  (( _prompt_title )) || return
  print -n '\e]0;'; print -rn -- "${${1[1,80]}//[[:cntrl:]]/ }"; print -n '\a'
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _prompt_precmd
add-zsh-hook preexec _prompt_preexec

PROMPT='%(!.%F{red}.%F{green})%n%f%F{244}@%f%F{$_prompt_host_color}%m%f %F{blue}%~%f'
PROMPT+='$_prompt_git'
PROMPT+='%(1j. %F{244}⚙%j%f.)'
PROMPT+=$'\n''%(?..%F{red}✘%? )%(?.%F{green}.%F{red})❯%f '
RPROMPT=
