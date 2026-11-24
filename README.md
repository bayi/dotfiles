
# Installation
- `git clone --recursive https://github.com/bayi/dotfiles.git ~/.dotfiles`
- `cd ~/.dotfiles`
- To install/update the config files, run: `./install`

The installer only symlinks what makes sense on the given host: `home/<name>` goes to `~/.<name>`,
`config/<name>` to `~/.config/<name>`, and each entry can have a condition (see `wanted()` in `install`) —
e.g. the Hyprland config is only linked where Hyprland is installed, the nvim config only where nvim is.
Real files/directories are never touched, only symlinks.

- `./install -n` — dry-run, only prints what it would do
- `./install --prune` — also removes symlinks pointing into `~/.dotfiles` that are not needed on this host
  or whose source is gone. Careful with a shared (NFS) home: run it on the desktop machine.

# Update
- `git pull && git submodule update --init --recursive && ./install`

# Wallpapers
Not stored in the repo. `home/bin/fetch-wallpapers` downloads the files listed in `wallpapers.list`
into `~/.dotfiles/assets` (only on hosts with Wayland/Hyprland; `./install` runs it).

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
