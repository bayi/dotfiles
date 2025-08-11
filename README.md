
# Important!
Install to: `~/.dotfiles` and edit `install` file and change the path.

# Installation
- `git clone --recursive https://github.com/bayi/dotfiles.git ~/.dotfiles`
- cd ~/.dotfiles
- To install/update the config files, run: `./install`

# Update
- run `./update-modules`

# Configuration
To enable/disable modules edit `install` file. Also if you want you can set the `path=` variable in `Zsh/zshrc`.

## Basic requirements
 - zsh              -> Shell
 - neovim           -> Text editor
 - git              -> Version control

## Window manager
 - uwsm hyprland hyprpaper hyprpicker hypridle hyprshot waybar wayvnc wofi mako cliphist

# Fonts:
 - ttf-firacode-ned -> Main font
 - otf-font-awesome -> Icon font

# Apps:
 - nautilus         -> File manager
 - alacritty        -> Terminal
 - pipewire         -> Audio
 - mpv              -> Media Player

# Optional:
 - libqalculate     -> Calculator support, used as an alias in the shell with "?"
 - nvm              -> Node version manager

# All in one desktop installer

## Official repository
```
    sudo pacman -S zsh git neovim uwsm hyprland hyprpaper hyprpicker hypridle hyprshot waybar wayvnc mako wofi cliphist ttf-firacode-ned otf-font-awesome alacritty mpv meld file-roller imv
```
