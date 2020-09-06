#!/usr/bin/env bash

function run {
	if (command -v $1 && ! pgrep $1); then
    $@&
  fi
}

if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
  /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi
#/usr/bin/lxpolkit &

run nm-applet
#run pamac-tray
#run xfsettingsd

#run thunar --daemon
run nitrogen --restore
#run fromscratch
run numlockx

run compton --shadow-exclude '!focused'
