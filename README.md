
# Important!
Install to: `~/.dotfiles` and edit `install` file and change the path. 

# Installation
- `git clone --recursive https://github.com/bayi/dotfiles.git ~/.dotfiles`
- cd ~/.dotfiles
- To install/update the config files, run: `./install`

# Update
- git submodule foreach git pull origin master

# Configuration
To enable/disable modules edit `install` file. Also if you want you can set the `path=` variable in `Zsh/zshrc`.

# xorg needed packages:
 - xorg-setxkbmap   -> Keyboard language management
 - xorg-xrandr      -> Multi monitor management

# Fonts:
 - otf-fira-code    -> Font
 - ttf-font-awesome -> Icon font

# Apps:
 - zsh              -> Shell
 - i3-gaps          -> Window manager
 - i3blocks         -> Status bar
 - vim/neovim       -> Text editor
 - nautilus         -> File manager
 - qdmenu           -> App launcher
 - kitty            -> Terminal
 - pulseaudio       -> Audio
 - mpv              -> Media Player
 - dunst            -> Notifications
 ... bunch of gnome apps

# All in one desktop package installer
```
 pacman -S gvim zsh i3-gaps i3blocks nautilus mpv kitty gnome-calculator gnome-calendar gnome-clocks gnome-contacts gnome-control-center gnome-disk-utility gnome-flashback gnome-keyring gnome-logs gnome-photos gnome-screenshot gnome-shell gnome-shell-extensions gnome-software-packagekit-plugin gnome-usage gnome-tweaks gnome-user-share chromium gdm lxappearance file-roller xorg-xrandr xorg-setxkbmap dunst
 aurman -S qdmenu i3-gnome-git otf-fira-code-git
```
