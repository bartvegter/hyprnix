#!/usr/bin/env bash

wgStatus() {
  if [[ $(systemctl is-active wg-quick-proton) ]]; then
    notify-send -a WaybarWG "Wireguard" "Wireguard is running\nRight click module to toggle connection"
  else
    notify-send -a WaybarWG "Wireguard" "Wireguard not is running\nRight click module to toggle connection"
  fi
}

wgToggle() {
  if [[ $(systemctl is-active wg-quick-proton) ]]; then
    systemctl stop wg-quick-proton &&
    notify-send -a WaybarWG "Wireguard" "Stopped wireguard connection"
  else
    systemctl start wg-quick-proton &&
    notify-send -a WaybarWG "Wireguard" "Started wireguard connection"
  fi
}

if [[ $1 == "status" ]]; then
  wgStatus
elif [[ $1 == "toggle" ]]; then
  wgToggle
else
  notify-send -a WaybarWG "Wireguard" "Invalid arguments\nValid arguments are 'status' or 'toggle'"
fi
