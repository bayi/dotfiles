
# Important!
Install to: `~/.dotfiles` and/or edit `install` file and change the path and in Zsh/zshrc change the path also. Then run `install`

# Installation
- git submodule init
- git submodule update
- To install/update the config files, run: `./install`

# Update
- git submodule foreach git pull origin master

# Configuration
To enable/disable modules edit `install` file. Also if you want you can set the `path=` variable in `Zsh/zshrc`.

# xorg needed packages:
 - xorg-setxkbmap   -> Keyboard language management
 - xorg-xrandr      -> Multi monitor management
 - xorg-xset        -> X power management

# Fonts:
 - otf-fira-code    -> Font
 - ttf-font-awesome -> Icon font

# Apps:
 - zsh              -> Shell
 - i3-wm            -> Window manager
 - i3blocks         -> Status bar
 - vim/neovim       -> Text editor
 - nautilus         -> File manager
 - qdmenu           -> App launcher
 - kitty            -> Terminal
 - pulseaudio       -> Audio
 - most             -> Pager
 - mpv              -> Media Player
 ... bunch of gnome apps

# optional packages:
 - vim plugins: vim-airline vim-fugitive vim-surround vim-omnicppcomplete

# All in one desktop package installer
```
 pacman -S vim zsh i3-wm i3blocks nautilus most mpv kitty gnome-calculator gnome-calendar gnome-clocks gnome-contacts gnome-control-center gnome-disk-utility gnome-flashback gnome-keyring gnome-logs gnome-photos gnome-screenshot gnome-shell gnome-shell-extensions gnome-software-packagekit-plugin gnome-system-monitor gnome-todo gnome-tweaks gnome-user-share chromium gdm lxappearance gnumeric file-roller abiword
 aurman -S qdmenu i3-gnome otf-fira-code-git
```

# Example arch linux install:
```
 git --recursive clone https://github.com/bayi/dotfiles.git ~/.dotfiles
 cd .dotfiles
 ./install
```
