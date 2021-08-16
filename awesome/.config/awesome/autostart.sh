#!/bin/bash

function run {
  if ! pgrep $1; then
    $@ &
  fi
}

# keyboard layout
setxkbmap -layout us,us -variant ,intl -option 'grp:alt_space_toggle'

### Arco Linux default
run nm-applet
#run caffeine
run pamac-tray
run xfce4-power-manager
run blueberry-tray
run /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
run numlockx on
run volumeicon
# run nitrogen --restore
run variety
run conky -c $HOME/.config/awesome/system-overview

### My runs
run imwheel
# run liquidctl initialize all # NZXT smart device v2 config

# load the config file from arandr
#create a weird bug where it display horizontal
(
  sleep 1
  run $HOME/.screenlayout/init.sh
) &

# polybar
# (sleep 2; run $HOME/.config/polybar/launch.sh) &