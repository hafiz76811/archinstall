#!/bin/bash

conf=false

source programs/functions.sh
source programs/packages
source programs/logos

# exit on any error
set -e

# update && upgrade
sudo pacman -Syyu


# install packages
# installing_logo
# pacman_install ${package_basic[@]};
# pacman_install ${package_hardware[@]};
# pacman_install ${basic_fonts[@]};
# pacman_install ${additional_tools[@]};


# install aur helper
source programs/yay.sh


# install gnome
source programs/desktop/gnome
read -p "Install... gnome? [Y/n] " gnome
if [ "$gnome" = "y" ] || [ -z "$gnome" ]; then
  gnome_logo
  pacman_install ${gnome_desktop[@]};
  # service_enable ${gnome_service[@]};
fi


# install hyprland
source programs/desktop/hyprland
read -p "Install... hyprland? [Y/n] " hypr
if [ "$hypr" = "y" ] || [ -z "$hypr" ]; then
  hyprland_logo
  pacman_install ${hypr_ecosystem[@]};
  yay_install ${hypr_ecosystem_aur[@]};
  pacman_install ${hypr_widget[@]};
  pacman_install ${hypr_login[@]};
  pacman_install ${hypr_bar[@]};
  pacman_install ${multimedia[@]};
  pacman_install ${hypr_theme[@]};
  # hyprland services
  service_enable ${hypr_service[@]};
  service_enable_user ${hypr_user_service[@]};
  service_disable ${hypr_disable[@]};

  if $conf; then
    git clone https://github.com/hafiz76811/hyprland.git
    if [ -d hyprland ]; then
      cp -r hyprland/* ~/.config/.
      rm -r ~/.config/.git
    fi
  fi
fi


# install bspwm
source programs/desktop/bspwm
read -p "Install... bspwm? [Y/n] " bspwm
if [ "$bspwm" = "y" ] || [ -z "$bspwm" ]; then
  bspwm_logo
  pacman_install ${bspwm_display_manager[@]};
  pacman_install ${bspwm_window_manager[@]};
  pacman_install ${bspwm_utilities[@]};
  pacman_install ${bspwm_bar[@]};
  pacman_install ${bspwm_touchpad[@]};
  # yay_install ${bspwm_aur[@]};
  pacman_install ${multimedia[@]};
  pacman_install ${bspwm_theme[@]};

  if $conf; then
    git clone https://github.com/hafiz76811/hyprland.git
    if [ -d bspwm ]; then
      cp -r bspwm/* ~/.config/.
      rm -r ~/.config/.git
    fi
  fi
fi


# reboot system
read -p "Reboot system now? [Y/n] " rb
if [ "$rb" = "y" ] || [ -z "$rb" ]; then
  if pacman -Qtdq &> /dev/null; then
    sudo pacman -Rns $(pacman -Qtdq)
  fi
  systemctl reboot
fi
