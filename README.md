
# Important!
Install to: `~/.dotfiles` and edit `install` file and change the path.

# Installation
- `git clone --recursive https://github.com/bayi/dotfiles.git ~/.dotfiles`
- cd ~/.dotfiles
- To install/update the config files, run: `./install`

# Update
- git submodule foreach git pull origin master or run `./update-modules`

# Configuration
To enable/disable modules edit `install` file. Also if you want you can set the `path=` variable in `Zsh/zshrc`.

# xorg needed packages:
 - xorg-setxkbmap   -> Keyboard language management
 - xorg-xrandr      -> Multi monitor management

# Fonts:
 - ttf-fira-code    -> Main font
 - ttf-font-awesome -> Icon font

# Apps:
 - zsh              -> Shell
 - i3-gaps          -> Window manager
 - i3blocks         -> Status bar
 - vim/neovim       -> Text editor
 - nautilus         -> File manager
 - qdmenu           -> App launcher
 - alacritty        -> Terminal
 - pipewire         -> Audio
 - mpv              -> Media Player
 ... bunch of gnome apps

# Optional:
 - libqalculate     -> Calculator support, used as an alias in the shell with "?"
 - nvm              -> Node version manager

# All in one desktop installer

## Official repository
```
pacman -S gvim zsh i3-gaps i3-gnome i3blocks nautilus mpv alacritty gnome-calendar gnome-clocks gnome-contacts gnome-control-center gnome-disk-utility gnome-flashback gnome-keyring gnome-logs gnome-screenshot gnome-shell gnome-usage gnome-user-share firefox gdm file-roller nautilus xorg-xrandr xorg-setxkbmap xorg-xhost xorg-xprop ttf-fira-code
```

## AUR
```
yay -S qdmenu
```
