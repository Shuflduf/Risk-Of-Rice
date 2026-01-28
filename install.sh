#!/bin/bash

export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"

echo "========================================="
echo "Risk-Of-Rice Installation Script"
echo "========================================="
echo ""
echo "This will install packages and configure your system."
echo ""
read -p "Press any key to start installation..." -n1 -s
echo ""
echo ""

if ! command -v yay &> /dev/null; then
    echo "yay is not installed. Installing yay first..."
    sudo pacman -S --needed git base-devel
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd -
    echo "yay installed successfully!"
    echo ""
fi

sudo pacman -S \
  hyprland \
  polkit-kde-agent \
  xdg-desktop-portal-hyprland \
  qt6-wayland \
  dunst \
  playerctl \
  networkmanager \
  bluez-utils \
  upower \
  ghostty \
  zoxide \
  yazi \
  starship \
  quickshell \
  pulsemixer \
  power-profiles-daemon \
  lazygit \
  impala \
  hyprsunset \
  hyprpaper \
  hyprshot \
  hyprpicker \
  hyprlock \
  hyprlauncher \
  hypridle \
  helix \
  fish \
  eza \
  btop \
  bluetui \
  7zip

yay -S \
  spotify \
  pacsea-bin \
  zen-browser-bin

mkdir -p $XDG_CONFIG_HOME/fish/
mkdir -p $XDG_CONFIG_HOME/quickshell/
mkdir -p $XDG_CONFIG_HOME/hypr/
mkdir -p $XDG_DATA_HOME/Risk-Of-Rice/wallpapers

mkdir -p ~/.local/share/fonts/
mkdir -p ~/Pictures/Screenshots

cp -f ./config.fish $XDG_CONFIG_HOME/fish/
cp -rf ./quickshell/* $XDG_CONFIG_HOME/quickshell/
cp -f ./hyprland.conf $XDG_CONFIG_HOME/hypr/
cp -rf ./wallpapers/* $XDG_DATA_HOME/Risk-Of-Rice/wallpapers
cp -f ./rzpix.ttf ~/.local/share/fonts/

fc-cache -fv
chsh -s $(which fish)

sudo systemctl enable --now power-profiles-daemon
sudo systemctl enable --now bluetooth

echo ""
echo "========================================="
echo "Installation complete!"
echo "========================================="
echo ""
echo "You need to log out or reboot for all changes to take effect."
echo ""
read -p "Press any key to reboot now (or Ctrl+C to cancel)..." -n1 -s
echo ""
sudo reboot
