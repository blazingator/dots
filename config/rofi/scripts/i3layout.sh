#!/bin/bash

rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/i3layout.rasi"

stacked=""
tabbed=""
split=""

options="$stacked\n$tabbed\n$split"

chosen="$(echo -e "$options" | $rofi_cmd -dmenu -p "i3layout")"

case $chosen in
  $stacked)
    i3-msg layout stacked
    ;;
  $tabbed)
    i3-msg layout tabbed
    ;;
  $split)
    i3-msg layout toggle split
    ;;
esac
