#!/bin/bash

sudo pacman -S \
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
  hyprshot \
  hyprpicker \
  hyprlock \
  hyprlauncher \
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

mkdir -p ${XDG_CONFIG_HOME}/fish/
cp -f ./config.fish $XDG_CONFIG_HOME/fish/

mkdir -p ~/Pictures/Screenshots

