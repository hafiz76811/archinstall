#!/bin/bash

pacman_install() {
  local package=$@
  for pkg in ${package[@]}; do
    sudo pacman -Sy --needed --noconfirm ${pkg}
  done
}

pacman_remove() {
  local package=$@
  for pkg in ${package[@]}; do
    sudo pacman -Rns ${pkg}
  done
}

yay_install() {
  local package=$@
  for pkg in ${package[@]}; do
    yay -Sy --needed --noconfirm ${pkg}
  done
}

service_enable() {
  local service=$@
  for srv in ${service[@]}; do
    systemctl enable --now ${srv}
  done
}

service_enable_user() {
  local service=$@
  for srv in ${service[@]}; do
    systemctl --user enable --now ${srv}
  done
}

service_disable() {
  local service=$@
  for srv in ${service[@]}; do
    systemctl disable --now ${srv}
  done
}
