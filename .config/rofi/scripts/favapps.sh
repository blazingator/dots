#!/usr/bin/env bash

rofi_cmd="rofi -theme $HOME/.config/rofi/scripts/favapps.rasi"

# Options
firefox=""
#term=""
term=""
sysmon=""
vim=""
fm=""
conf=""

confDirs(){
  local localConf="$HOME/.config"
  local rofi_cmd="rofi -theme $localConf/rofi/scripts/favappsconf.rasi"

  i3Conf="i3"
  rofiConf="rofi"
  polybarConf="polybar"
  vimConf="vim"
  
    local options="$i3Conf\n$rofiConf\n$polybarConf\n$vimConf"

  local chosen="$(echo -e "$options" | $rofi_cmd -p "Config" -dmenu)"
  
  case $chosen in
    $i3Conf)
      nvim-qt +"CocCommand explorer $localConf/i3"
      ;;
    $rofiConf)
      nvim-qt +"CocCommand explorer $localConf/rofi"
      ;;
    $polybarConf)
      nvim-qt +"CocCommand explorer $localConf/polybar"
      ;;
    $vimConf)
      nvim-qt +"CocCommand explorer $localConf/nvim"
      ;;
  esac
}

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
    confDirs
    ;;
esac
