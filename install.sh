#!/bin/bash

source programs/functions.sh
source programs/packages
#
set -e
sudo pacman -Syyu
#
pacman_install ${package_basic[@]};
pacman_install ${package_hardware[@]};
pacman_install ${basic_fonts[@]};
pacman_install ${additional_tools[@]};
#
#
source programs/yay.sh
#
#
source programs/desktop/gnome
#
read -p "Install... gnome? [Y/n] " gnome
if [ "$gnome" = "y" ] || [ -z "$gnome" ]; then
  pacman_install ${gnome_desktop[@]};
  service_enable ${gnome_service[@]};
fi
#
#
source programs/desktop/hyprland
#
read -p "Install... hyprland? [Y/n] " hypr
if [ "$hypr" = "y" ] || [ -z "$hypr" ]; then
  pacman_install ${hypr_ecosystem[@]};
  yay_install ${hypr_ecosystem_aur[@]};
  pacman_install ${hypr_widget[@]};
  pacman_install ${hypr_login[@]};
  pacman_install ${waybar_tools[@]};
  pacman_install ${multimedia[@]};
  pacman_install ${adwaita_theme[@]};
  # hyprland services
  service_enable ${hypr_service[@]};
  service_enable_user ${hypr_user_service[@]};
  service_disable ${hypr_disable[@]};
fi
#
#
read -p "Reboot system now? [Y/n] " rb
if [ "$rb" = "y" ] || [ -z "$rb" ]; then
  systemctl reboot
fi
