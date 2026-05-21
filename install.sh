#!/bin/bash

# Hubungkan files
source programs/functions/functions
source programs/functions/logos/styling

# Clear dan tampilkan logo
clear
installing_logo
sleep 2

# Hentikan script jika ada error
set -e

# Update dan upgrade system
echo 'Update and upgrade system...'
sudo pacman -Syyu

# Install banyak packages dasar
echo -e "\nInstalling basic packages..."
basic_packages=$(cat programs/packages/pacman/basic_packages)
pacman_install ${basic_packages[@]}

hardware_packages=$(cat programs/packages/pacman/hardware_packages)
pacman_install ${hardware_packages[@]}

additional_tools=$(cat programs/packages/pacman/additional_tools)
pacman_install ${additional_tools[@]}

basic_fonts=$(cat programs/packages/pacman/basic_fonts)
pacman_install ${basic_fonts[@]}

# Clear dan tampilkan logo hyprland
clear
hyprland_logo
sleep 2

# Memasang aur helper (yay)
echo -e "\nInstalling aur helper..."
source programs/packages/yay/aur_helper

# Install semua packages hyprland
echo 'Installing hyprland...';
hypr_ecosystem=$(cat programs/desktop/hyprland/hypr_ecosystem)
pacman_install ${hypr_ecosystem[@]}

hypr_ecosystem_aur=$(cat programs/desktop/hyprland/hypr_ecosystem_aur)
yay_install ${hypr_ecosystem_aur[@]}

display_manager=$(cat programs/desktop/hyprland/display_manager)
pacman_install ${display_manager[@]}

other_packages=$(cat programs/desktop/hyprland/other_packages)
pacman_install ${other_packages[@]}

waybar_packages=$(cat programs/desktop/hyprland/waybar_packages)
pacman_install ${waybar_packages[@]}

multimedia_tools=$(cat programs/desktop/hyprland/multimedia_tools)
pacman_install ${multimedia_tools[@]}

adwaita_theme=$(cat programs/desktop/hyprland/adwaita_theme)
pacman_install ${adwaita_theme[@]}

# Melakukan konfigurasi pada hyprland
echo -e "\nConfiguring hyprland..."
source programs/desktop/hyprland/hypr_configurations

# Mengatur systemd services
echo -e "\nSet up systemd services..."; sleep 2
services=$(cat programs/systemd/enable/services)
systemctl_enable ${services[@]}

user_services=$(cat programs/systemd/enable/user_services)
systemctl_user_enable ${user_services[@]}

service=$(cat programs/systemd/disable/service)
systemctl_disable ${service[@]}

# Jalankan konfigurasi lain
echo -e "\nAdditional configurations..."
source programs/functions/commands/other

echo "";

# Reboot system setelah siap
read -p "Reboot system now? [Y/n] " reboot
if [ "$reboot" == "y" ]; then
  systemctl reboot
fi
