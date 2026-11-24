# Login shell környezet (a .zshrc előtt). Nem-login, nem-interaktív shellnek a ~/.zshenv tölti be.

# Szerkesztő, lapozó, nyelv
if [[ -z "$EDITOR" ]]; then
  if   (( $+commands[nvim] )); then export EDITOR=nvim
  elif (( $+commands[vim]  )); then export EDITOR=vim
  else                              export EDITOR=nano
  fi
fi
[[ -z "$VISUAL" ]] && export VISUAL=$EDITOR
[[ -z "$PAGER"  ]] && export PAGER=less
[[ -z "$LANG"   ]] && export LANG=en_US.UTF-8

export LESS='-g -i -M -R -S -w'
if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export WAM_SHARED="$HOME/Projektek/Webandmore/Internal"
export NVM_DIR="$HOME/.nvm"
export PNPM_HOME="$HOME/.local/share/pnpm"

# PATH: csak ami tényleg létezik ezen a gépen ((N-/) = létező mappa, különben kimarad)
typeset -gU cdpath fpath mailpath path
path=(
  $HOME/.{,s}bin(N-/)
  $HOME/.local/{,s}bin(N-/)
  $HOME/.yarn/bin(N-/)
  $HOME/.config/composer/vendor/bin(N-/)
  $PNPM_HOME(N-/)
  $WAM_SHARED/bin(N-/)
  /usr/local/{,s}bin(N-/)
  $path
)

# Desktop (csak ahol van Hyprland)
if (( $+commands[Hyprland] )); then
  export GTK_THEME=Adwaita:dark
  export WLR_DRM_DEVICES=/dev/dri/card1
  export GSK_RENDERER=ngl

  # tty1-en indul a Hyprland
  if [[ $(tty) == /dev/tty1 ]] && (( $+commands[uwsm] )); then
    echo " * Starting Hyprland..."
    if uwsm check may-start; then
      exec uwsm start hyprland.desktop
    fi
  fi
fi
