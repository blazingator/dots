#!/usr/bin/env bash

rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/powermenu.rasi"

#Options
shutdown=" "
reboot=""
lock=""

options="$shutdown\n$reboot\n$lock"

chosen="$(echo -e "$options" | $rofi_cmd -p "Power menu" -dmenu)"
case $chosen in
  $shutdown)
    systemctl poweroff
    ;;
  $reboot)
    systemctl reboot
    ;;
  $lock)
    i3lock-fancy
    ;;
esac
