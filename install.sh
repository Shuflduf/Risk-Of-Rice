#!/bin/bash

sudo pacman -S \
  hyprland \
  polkit-kde-agent \
  xdg-desktop-portal-hyprland \
  dunst \
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

mkdir -p ~/Pictures/Screenshots

cp -f ./config.fish $XDG_CONFIG_HOME/fish/
cp -rf ./quickshell/* $XDG_CONFIG_HOME/quickshell/
cp -f ./hyprland.conf $XDG_CONFIG_HOME/hypr/
cp -rf ./wallpapers/* $XDG_DATA_HOME/Risk-Of-Rice/wallpapers

chsh -s $(which fish)
sudo systemctl enable --now power-profiles-daemon
