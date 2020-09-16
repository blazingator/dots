#!/usr/bin/env bash

rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/favapps.rasi"

# Options
firefox=""
term=""
sysmon=""
vim=""
fm=""
conf=""
i3="i3"
polybar="polybar"

options="$firefox\n$term\n$sysmon\n$vim\n$fm\n$conf"

chosen="$(echo -e "$options" | $rofi_cmd -p "Apps" -dmenu)"
case $chosen in
  $term)
    lxterminal &
    ;;
  $firefox)
    firefox &
    ;;
  $sysmon)
    lxterminal -e bpytop &
    ;;
  $vim)
    lxterminal -e nvim &
    ;;
  $fm)
    thunar &
    ;;
 $conf)
    lxterminal -e nvim --cmd NERDTree ~/.config &
    ;;
esac
