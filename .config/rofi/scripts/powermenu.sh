#!/usr/bin/env bash

#confirm dialog
function confirm() {
  rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/confirmdialog.rasi"
  local options="Sim\nNão"
  local promptMsg=$2
  local chosen="$(echo -e "$options" | $rofi_cmd -p "$promptMsg" -dmenu)"
  case $chosen in
    "Sim")
      $1
    ;;
    "Não")
      return
    ;;
  esac
}

rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/powermenu.rasi"

#Options
shutdown=""
reboot=""
lock=""
logout=""

options="$shutdown\n$reboot\n$lock\n$logout"

chosen="$(echo -e "$options" | $rofi_cmd -p "Power menu" -dmenu)"
case $chosen in
  $shutdown)
    confirm "systemctl poweroff" "Desligar?"
    ;;
  $reboot)
    confirm "systemctl reboot" "Reiniciar" 
    ;;
  $lock)
    i3lock-fancy
    ;;
  $logout)
    confirm "i3-msg exit" "Sair do i3?"
    ;;
esac
